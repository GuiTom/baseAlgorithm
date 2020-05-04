//
//  AVLTree.m
//  BaseAlgorithm
//
//  Created by 陈超 on 2020/5/2.
//  Copyright © 2020年 kayak. All rights reserved.
//

#import "AVLTree.h"
typedef struct Node{
   int key;
   struct Node *left;
   struct Node *right;
   struct Node *parent;
   int height;
   int distanceToRoot;
}Node;
typedef struct LinkNode{
    Node*node;
    int nodeDepth;
   struct LinkNode*next;
}LinkNode;

@implementation AVLTree

static Node *root;

static int leftminDistance = 0;//主意，根节点左边的节点到根节点的距离为负数
static int rightMaxDistance = 0;
static int currentLevel = 0;
static int maxLevel = 0;
-(void)test{
    int arr[] = {99,14,2,3,6,7,11,45,21,89,97,32,54,13};
    int len = sizeof(arr)/sizeof(*arr);
    root = NULL;
    for (int i=0;i<len;i++) {
        Node *node = (Node*)calloc(1, sizeof(Node));
        node->key = arr[i];
        node->height = 1;
        node->distanceToRoot = 0;
        addNode(node);
        
    }
    
    travelPreOrder(root);
    printNodeInLevel(root);
}
void travelPreOrder(Node*node){
    currentLevel++;
    if(currentLevel>maxLevel){
        maxLevel = currentLevel;
    }
    if(node->left){
        node->left->distanceToRoot = node->distanceToRoot - 1;
        if(leftminDistance>node->left->distanceToRoot){
            leftminDistance = node->left->distanceToRoot;
        }
        travelPreOrder(node->left);
    }
    if(node->right){
        node->right->distanceToRoot = node->distanceToRoot + 1;
        if(rightMaxDistance<node->right->distanceToRoot){
            rightMaxDistance = node->right->distanceToRoot;
        }
        travelPreOrder(node->right);
    }
    currentLevel --;
}
void addNode(Node *node){
    
    if(!root){
        root = node;
        return;
    }
    Node *parent = root;
    while(true){//找到合适的位置插入节点
      
        if(node->key<parent->key){
            if(!parent->left){
                parent->left = node;
                node->parent = parent;
                break;
            }else {
                parent = parent->left;
                
            }
        }else if(node->key>parent->key){
            if(!parent->right){
                parent->right = node;
                node->parent = parent;
                break;
            }else {
                parent = parent->right;
                
            }
        }
    }
 
    //更新高度
    Node *p = node->parent;
    while(p){
        p->height = getHeight(p);
        p = p->parent;
    }
    Node *grandParent = parent->parent;//新添加节点的 grandParent 才有可能失衡
    Node *child = NULL;//记住 grandParent 是其父母的左子节点还是右子节点，因为在旋转后可能不知道那个节点替换 grandParent 的位置
    if(grandParent){
        if(grandParent->parent){
            if(grandParent==grandParent->parent->left){
                child = grandParent->parent->left;
            }else {
                child = grandParent->parent->right;
            }
        }else {
            child = root;
        }
    }

    Node *nodeLostBalance = checkBalance(node);
    if(nodeLostBalance){//失去平衡
         adJustBalance(nodeLostBalance);
        //更新高度
        updateHeight(nodeLostBalance);
        
    }
}
void updateHeight(Node *node){
    int leftHeight = 0;
    if(node->left){
        updateHeight(node->left);
        leftHeight = node->left->height;
        
    }
    int rightHeight = 0;
    if(node->right){
        updateHeight(node->right);
        rightHeight = node->right->height;
    }
    if(node->left==NULL&&node->right==NULL)
    {
       
        node->height= 1;
    }else {
        node->height = MAX(leftHeight+1, rightHeight+1);
    }
}
int getHeight(Node *node){
    if(node==NULL){
        return 0;
    }
    int leftHeight = 0,rightHeight = 0;
    if(node->left){
        leftHeight = node->left->height;
    }
    if(node->right){
        if(node->right->height>rightHeight){
            rightHeight = node->right->height;
        }
    }
    return MAX(leftHeight, rightHeight)+1;
}
void adJustBalance(Node *node){
    int leftHeight = 0,rightHeight = 0;
    if(node->left){
        leftHeight = node->left->height;
    }
    if(node->right){
        rightHeight = node->right->height;
    }
    if(leftHeight>rightHeight){//左边失衡
        Node *left = node->left;
        leftHeight = 0;rightHeight = 0;
        if(left->left){
            leftHeight = left->left->height;
        }
        if(left->right){
            rightHeight = left->right->height;
        }
        if(leftHeight>rightHeight){//LL型
            rotateRight(node);
        }else {//LR型
            rotateLeft(left);
            rotateRight(node);
        }
    }else{//右边失衡
        Node *right = node->right;
        leftHeight = 0;rightHeight = 0;
        if(right->left){
            leftHeight = right->left->height;
        }
        if(right->right){
            rightHeight = right->right->height;
        }
        if(leftHeight>rightHeight){//RL型
            rotateRight(right);
            rotateLeft(node);
        }else {//RR型
            rotateLeft(node);
        }
    }

}
/**
 右旋的定义是把左边的部下提升为上级，顶替自己，自己给左边的部下当右部下
 */
void rotateRight(Node*node){
    Node *parent = node->parent;
    Node *left = node->left;
    if(parent){
        if(parent->left==node){
            parent->left = left;
        }
        if(parent->right==node){
            parent->right = left;
        }
    }else {
        root = left;
    }
    left->parent = parent;
    //左部下原来的右部下（如果有）作为自己的左部下
    if(left->right){
        left->right->parent = node;
    }
    node->left = left->right;
    //自己作为原来来的左部下的右部下
    left->right = node;
    node->parent = left;
}
/**
左旋的定义是把右边的部下提升为上级，顶替自己，自己给右边的部下当左部下
 */
void rotateLeft(Node *node){
    Node *parent = node->parent;
    Node *right = node->right;
    if(parent){
        if(parent->left==node){
            parent->left = right;
        }
        if(parent->right==node){
            parent->right = right;
        }
    }else {
        root = right;
    }
    right->parent = parent;
    //右部下原来的左部下(如果有)作为自己的右部下
    if(right->left){
        right->left->parent = node;
    }
    node->right = right->left;
    //自己作为原来来的右部下的左部下
    right->left = node;
    node->parent = right;
}
Node* checkBalance(Node *node){
 
    int leftHeight = 0,rightHeight = 0;
    if(node->left){
        leftHeight = node->left->height;
        
    }
    if(node->right){
        rightHeight = node->right->height;
    }
    if(abs(leftHeight-rightHeight)>=2){
        return node;
    }else {
        if(node->parent){
            return  checkBalance(node->parent);
        }else {
            return NULL;
        }
    }
}
void deleteNode(Node *node){
    
}

void printNodeInLevel(Node *parent){
    if(parent==NULL) return;
    LinkNode linkNode = {parent,0,NULL};
    LinkNode *head = &linkNode;
    
    LinkNode *tail = head;
    int nodeDepth = tail->nodeDepth;
  
//    int leftBlankSpaceCount = 0;
//    int maxDistanceAbs = MAX(-leftminDistance, rightMaxDistance);
    int keyWidth = 2;//打印的key 占几个字节
    if(maxLevel>5){//控制台的长度有限，层数过多会造成强制换行，显示混乱
        maxLevel = 5;
    }
    int maxDistanceAbs = keyWidth*powl(2, maxLevel);
    int lastBlackSpaceCount = 0;
    while (1) {
        int blackSpaceCountToPrint = 0;
        if(head->node->parent&&head->node == head->node->parent->left){//是其父节点的左子节点
            head->node->distanceToRoot = head->node->parent->distanceToRoot - maxDistanceAbs/powl(2,head->nodeDepth);
        }else if(head->node->parent&&head->node == head->node->parent->right){////是其父节点的右子节点
            head->node->distanceToRoot = head->node->parent->distanceToRoot + maxDistanceAbs/powl(2,head->nodeDepth);
        }else {//是根节点
            head->node->distanceToRoot = 0;
        }
        if(nodeDepth==0||nodeDepth!=head->nodeDepth){//新一层的开头
            blackSpaceCountToPrint = head->node->distanceToRoot+maxDistanceAbs;
            lastBlackSpaceCount = blackSpaceCountToPrint;
            nodeDepth = head->nodeDepth;
            printf("\n");
        }else{//不是新一层的开头
            int leftBlackSpaceCount = head->node->distanceToRoot+maxDistanceAbs;
            blackSpaceCountToPrint = leftBlackSpaceCount - lastBlackSpaceCount;
            lastBlackSpaceCount = leftBlackSpaceCount;
        }
        int _blankSpaceCountToPrint = blackSpaceCountToPrint;
        while (blackSpaceCountToPrint--) {
            printf(" ");
        }
        printf("%d",head->node->key);
        if(parent->left){
            LinkNode *newNode = (LinkNode*)calloc(1, sizeof(LinkNode));
            newNode->node = parent->left;
            newNode->nodeDepth = head->nodeDepth + 1;
            tail->next = newNode;
            tail = newNode;
        }
        if(parent->right){

            LinkNode *newNode = (LinkNode*)calloc(1, sizeof(LinkNode));
            newNode->node = parent->right;
            newNode->nodeDepth = head->nodeDepth+1;
            tail->next = newNode;
            tail = newNode;
        }
        
        if(head->next){
            head = head->next;
            parent = head->node;
        }else {
            head = NULL;
            break;
        }
        
    }
}
@end
