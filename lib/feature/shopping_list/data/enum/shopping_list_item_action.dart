enum ShoppingListItemAction {
  create('Create'),
  update('Update');

  const ShoppingListItemAction(this.label);

  final String label;
}
