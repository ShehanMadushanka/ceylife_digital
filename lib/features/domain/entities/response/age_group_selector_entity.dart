class AgeGroupSelectorEntity {
  final String title;
  final bool isInitialItem;
  bool isSelected;

  AgeGroupSelectorEntity(
      {this.title, this.isSelected = false, this.isInitialItem = false});
}
