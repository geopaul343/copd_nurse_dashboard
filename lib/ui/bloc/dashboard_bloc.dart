import '../../data/repository/dashboard/dashboard_repo_impl.dart';

class DashboardBloc{

  final DashBoardRepoImpl _repo = DashBoardRepoImpl();

  Future<void> searchUser({required String name}) async {
    await _repo.searchUser(name: name);
  }

}