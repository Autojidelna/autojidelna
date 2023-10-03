import 'package:autojidelna/every_import.dart';
import 'package:autojidelna/main.dart';

class SwitchAccountPanel extends StatefulWidget {
  const SwitchAccountPanel({
    super.key,
    required this.setHomeWidget,
  });
  final Function setHomeWidget;

  @override
  State<SwitchAccountPanel> createState() => _SwitchAccountPanelState();
}

class _SwitchAccountPanelState extends State<SwitchAccountPanel> {
  final ValueNotifier<LoggedAccountsInAccountPanel> loggedAccounts =
      ValueNotifier<LoggedAccountsInAccountPanel>(LoggedAccountsInAccountPanel(usernames: [], loggedInID: null));
  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(16.0),
  );
  void updateAccountPanel(LoginData loginData) {
    loggedAccounts.value.usernames.clear();
    for (int i = 0; i < loginData.users.length; i++) {
      loggedAccounts.value.usernames.add(loginData.users[i].username);
    }
    loggedAccounts.value = LoggedAccountsInAccountPanel(usernames: loggedAccounts.value.usernames, loggedInID: loginData.currentlyLoggedInId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? const Color(0xff323232) : Colors.white,
        ),
        child: FutureBuilder(
          future: getLoginDataFromSecureStorage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final loginData = snapshot.data as LoginData;
              updateAccountPanel(loginData);
              return ValueListenableBuilder(
                valueListenable: loggedAccounts,
                builder: (ctx, value, child) {
                  List<Widget> accounts = [];
                  for (int i = 0; i < value.usernames.length; i++) {
                    accounts.add(accountRow(context, value.usernames[i], i == value.loggedInID, i));
                  }
                  Widget addAccountButton = TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black,
                    ),
                    onPressed: () async {
                      //close before going to the page
                      SwitchAccountVisible().setVisible(false);
                      await Future.delayed(const Duration(milliseconds: 300));
                      if (mounted) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(setHomeWidget: widget.setHomeWidget)));
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add, size: 31),
                        SizedBox(width: 10),
                        Text(
                          "Přidat účet",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                  if (accounts.length > 4) {
                    accounts.insert(0, addAccountButton);
                  } else {
                    accounts.add(addAccountButton);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Účty",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 150, 150, 150),
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            addRepaintBoundaries: false,
                            reverse: accounts.length > 5 ? true : false,
                            itemCount: accounts.length,
                            itemBuilder: (context, index) => accounts[index],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          },
        ),
      ),
    );
  }

  Row accountRow(BuildContext context, String username, bool currentAccount, int id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (!currentAccount) {
                SwitchAccountVisible().setVisible(false);
                await Future.delayed(const Duration(milliseconds: 500));
                LoginData loginData = await getLoginDataFromSecureStorage();
                loginData.currentlyLoggedInId = id;
                saveLoginToSecureStorage(loginData);
                widget.setHomeWidget(LoggingInWidget(setHomeWidget: widget.setHomeWidget));
              } else {
                SwitchAccountVisible().setVisible(false);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle, size: 30),
                    const SizedBox(width: 10),
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                if (currentAccount) const Icon(Icons.check, size: 30),
              ],
            ),
          ),
        ),
        //Logout button
        IconButton(
          icon: const Icon(Icons.logout, size: 30),
          onPressed: () async {
            await logout(id: id);
            if (currentAccount) {
              SwitchAccountVisible().setVisible(false);
              await Future.delayed(const Duration(milliseconds: 500));
              widget.setHomeWidget(LoggingInWidget(setHomeWidget: widget.setHomeWidget));
            }
            updateAccountPanel(await getLoginDataFromSecureStorage());
          },
        ),
      ],
    );
  }
}