import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class userEvent {
  bool is_login;
  userEvent(this.is_login);
}
