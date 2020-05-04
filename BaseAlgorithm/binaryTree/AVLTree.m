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
    int arr[] = {99,14,2,3,6,7,21,89,97,32,33,8};
    int len = sizeof(arr)/sizeof(*arr);
    root = NULL;
    for (int i=0;i<len;i++) {
        Node *node = (Node*)calloc(1, sizeof(Node));
        node->key = arr[i];
        node->height = 1;
        node->distanceToRoot = 0;
        addNode(node);
    }
    printNodeInLevel(root);
    printf("\n-----------------------------\n");
    removeByKey(3);
    removeByKey(7);
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
int removeByKey(int key){
    Node *node = root;
    while(1){
        if(node->key>key){
            if(node->left){
                node = node->left;
            }else {
                return -1;
            }
        }else if(node->key<key){
            if(node->right){
                node = node->right;
            }else {
                return -1;
            }
        }else {
            removeNode(node);
            return 0;
        }
    }
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
 
    afterAdd(node);
}
void afterAdd(Node*node){
    //更新高度
    Node *p = node->parent;
    while(p){

        int balanced = isBalanced(p);
        if(balanced){//失去平衡
            
            p->height = getHeight(p);
            
        }else {
            adJustBalance(p);
            break;
        }
         p = p->parent;
    }

}
Node * findSuccessor(Node *node){//寻找后继节点
    if(node->right){//有右字树
        Node *left = node->right->left;
        while(left&&left->left){
            left = left->left;
        }
        return left;
    }else {//没有右子树
        Node *parent = node->parent;
        while(parent&&parent->left!=node){
            parent = node->parent;
        }
        return parent;
    }
 
}
void removeNode(Node*node){
    if(node->left&&node->right){//是度为2的节点
        //用它的后继替代它
        Node *successor = findSuccessor(node);
        //让后继和其 parent 切断联系
        if(successor->parent->left==successor){
            successor->parent->left = NULL;
        }else {
            successor->parent->right = NULL;
        }
        successor->parent = NULL;
        
        if(node->parent){
            if(node->parent->left == node){
                node->parent->left = successor;
            }else {
                node->parent->right = successor;
            }
            successor->parent = node->parent;
        }
       
        successor->left = node->left;
        node->left->parent = successor;
        successor->right = node->right;
        node->right->parent = successor;
    }else if(node->left||node->right){//是度为1的节点,让唯一的子节点成为自己 parent的子节点
        Node *child = node->left;
        if(!child){
            child = node->right;
        }
        if(node->parent){
            if(node->parent->left==node){
                node->parent->left = child;
            }else {
                node->parent->right = child;
            }
            child->parent = node->parent;
        }
        
    }else {//是叶子根节点
        if(node==root){//也是根节点
            root = nil;
        }else {//是叶子节点
            if(node->parent->left==node){
                node->parent->left = NULL;
            }else {
                node->parent->right = NULL;
            }
            
        }
    }
    //切断被删除的节点与原来的树的所有联系
    Node *parent = node->parent;
    node->parent = node->left = node->right = NULL;
    afterRemove(parent);
}
void afterRemove(Node *node){
    Node *p = node;
    while(p){
        if(isBalanced(p)){
            p->height = getHeight(p);
        }else {
            adJustBalance(p);
        }
        p = p->parent;
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
    if(node->key==3){
        int key = node->key;
        
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
    //更新高度
    node->height = getHeight(node);
    left->height = getHeight(left);
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
    //更新高度
    node->height = getHeight(node);
    right->height = getHeight(right);
    
}
int isBalanced(Node *node){
 
    int leftHeight = 0,rightHeight = 0;
    if(node->left){
        leftHeight = node->left->height;
        
    }
    if(node->right){
        rightHeight = node->right->height;
    }
    return abs(leftHeight-rightHeight)<2;
}
void deleteNode(Node *node){
    
}

void printNodeInLevel(Node *parent){
    travelPreOrder(root);
    if(parent==NULL) return;
    LinkNode linkNode = {parent,0,NULL};
    LinkNode *head = &linkNode;
    
    LinkNode *tail = head;
    int nodeDepth = tail->nodeDepth;
  
    int keyWidth = 2;//打印的key 占几个字节

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
        while (_blankSpaceCountToPrint--) {
            printf(" ");
        }
        int key = 0;
        if(head->node->parent){
            key = head->node->parent->key;
        }
//        printf("%02d{%d}{%d}{%d}",head->node->key,head->node->distanceToRoot,key,lastBlackSpaceCount);
        printf("%02d",head->node->key);
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
