import 'package:connectaa/common/common_widgets/error.dart';
import 'package:connectaa/features/select_contact/controller/select_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectContactScreen extends ConsumerWidget {
  static const routeName = "Select_contactScreen/";
  const SelectContactScreen({super.key});

  void selectContact(
      {required Contact contact,
      required WidgetRef ref,
      required BuildContext context}) {
    ref.read(selectContactControllerProvider).selectContact(contact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(getProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Column(
          children: [
            Expanded(
                child: contacts.when(
              data: (contact) {
                if (contact.isEmpty) {
                  return const Center(
                    child: Text("No contacts"),
                  );
                }
                return ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, index) {
                    final name = contact[index].displayName.toString();
                    final phoneNumber = contact[index].phones.first.number;
                    return InkWell(
                      onTap: () => selectContact(contact: contact[index] , context: context , ref:  ref),
                      child: Card(
                        elevation: 2,
                        color: Colors.white24,
                        child: ListTile(
                          leading: contact[index].photo == null
                              ? const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage("assets/user_icon.png"),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  backgroundImage:
                                      MemoryImage(contact[index].photo!),
                                ),
                          title: Text(
                            name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(phoneNumber),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stack) {
                return ErrorScreen(
                  error: error.toString(),
                );
              },
              loading: () => const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator())),
            )),
          ],
        ),
      ),
    );
  }
}
