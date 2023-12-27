
abstract class States {}

class AppInitial extends States {}

class CreateDBState extends States {}

class GoToHomeState extends States {}

class InsertDBState extends States {}

class GetDataFromDBState extends States {}

class ChangeButtonPressedState extends States {}

class ChangeButtonPressedStatee extends States {}

class ChangeBTMState extends States {}

class TypeOfTaskState extends States {}

class RadiobuttonTaskState extends States {}

class WeaklyState extends States {}

class ViewState extends States {}

class DeleteState extends States {}

class SignInErrorState extends States {
  final String error;
  SignInErrorState(this.error);
}

class SignInSuccessState extends States {}

class SignUpErrorState extends States {
  final String error;
  SignUpErrorState(this.error);
}

class SignUpSuccessState extends States {}

class DeleteTaskState extends States {}

class UpdateTaskState extends States {}

class UpdateNameState extends States {}

class ImagePickedState extends States {}

class UploadImageState extends States {}

class GetUserState extends States {}