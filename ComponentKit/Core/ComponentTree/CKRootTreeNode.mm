/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "CKRootTreeNode.h"

#import "CKTreeNodeWithChildren.h"
#import "CKRenderHelpers.h"

CKRootTreeNode::CKRootTreeNode(): _node([CKTreeNodeWithChildren new]) {};

void CKRootTreeNode::registerNode(id<CKTreeNodeProtocol> node, id<CKTreeNodeProtocol> parent) {
  CKCAssert(parent != nil, @"Cannot register a nil parent node");
  if (node) {
    _nodesToParentNodes[node.nodeIdentifier] = parent;
  }
}

id<CKTreeNodeProtocol> CKRootTreeNode::parentForNodeIdentifier(CKTreeNodeIdentifier nodeIdentifier) {
  CKCAssert(nodeIdentifier != 0, @"Cannot retrieve parent for an empty node");
  auto const it = _nodesToParentNodes.find(nodeIdentifier);
  if (it != _nodesToParentNodes.end()) {
    return it->second;
  }
  return nil;
}

bool CKRootTreeNode::isEmpty() {
  return _node.childrenSize == 0;
}

id<CKTreeNodeWithChildrenProtocol> CKRootTreeNode::node() {
  return _node;
}
