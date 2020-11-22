abstract class ItemState {}

class ItemIdleState implements ItemState {}

class ItemPushingState implements ItemState {}

class ItemErrorState implements ItemState {}

class ItemCreatedState implements ItemState {
  ItemCreatedState();
}
