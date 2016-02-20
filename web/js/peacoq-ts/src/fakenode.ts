class FakeNode extends ProofTreeNode {
  constructor() {
    super(undefined, undefined);
  }

  click(): void { throw "FakeNode"; }
  getAllDescendants(): ProofTreeNode[] { throw "FakeNode"; }
  getAllGoalDescendants(): GoalNode[] { throw "FakeNode"; }
  getFocusedChild(): ProofTreeNode { throw "FakeNode"; }
  getParent(): ProofTreeNode { throw "FakeNode"; }
  getViewChildren(): ProofTreeNode[] { throw "FakeNode"; }
  nodeWidth(): number { throw "FakeNode"; }
}
