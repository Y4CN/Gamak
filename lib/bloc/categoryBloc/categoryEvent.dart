class CategoryEvent{}


class CategoryRequestEvent extends CategoryEvent{
  String catId;
  CategoryRequestEvent(this.catId);
}