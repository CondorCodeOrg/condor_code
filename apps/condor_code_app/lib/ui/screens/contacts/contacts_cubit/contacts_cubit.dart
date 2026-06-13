import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/contacts/contacts_cubit/contacts_state.dart';

// TODO: Get data from firebase or other source.
class ContactsCubit extends BaseCubit<ContactsState> {
  ContactsCubit({required super.snackBarEventsProvider})
    : super(
        ContactsState(
          imageUrl: 'https://i.pravatar.cc/200?img=10',
          youTubeUrl: 'https://www.youtube.com/@Oleh_Savenko',
          telegramUrl: 'https://t.me/oleh_savenko_mobile_development',
          instagramUrl:
              'https://www.instagram.com/savavskoy.o?igsh=MTVmbWtsbmF2ZXN5MA==',
          linkedInUrl:
              'https://www.linkedin.com/in/oleh-savenko-7051061ba?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
        ),
      );
}
