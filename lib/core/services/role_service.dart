import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoleService extends GetxService{

  final storage = GetStorage();
  late Role role;

  @override
  void onInit() {

    role = getRole();

    super.onInit();
  }


  Role getUpdatedRole(){
    return getRole();
  }

  Role getRole() {

    final roleString = storage.read(roleKey);

    if (roleString == null) {
      return Role.student;
    }

    return Role.values.firstWhere(
          (e){
        return e.name == roleString;
      },
      orElse: () => Role.student,
    );
  }

  void updateRole(Role newRole) {
    role = newRole;
    storage.write(roleKey, newRole.name);
  }

}