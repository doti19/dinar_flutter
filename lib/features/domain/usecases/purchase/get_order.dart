import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/membership_package_repository.dart';
import '../../entities/nhagiare/purchase/order_membership_package.dart';

class GetOrderMembershipPackageUseCase
    implements
        UseCase<DataState<OrderMembershipPackage>, Map<String, dynamic>> {
  final MembershipPackageRepository _membershipPackageRepository;

  GetOrderMembershipPackageUseCase(this._membershipPackageRepository);

  @override
  Future<DataState<OrderMembershipPackage>> call(
      {Map<String, dynamic>? params}) {
    return _membershipPackageRepository.createOrder(
        params!['package_id'], params['num_of_month']);
  }
}
