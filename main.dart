import 'package:flutter/material.dart';

void main() {
  runApp(const LiberationWarThemeApp());
}

class LiberationWarThemeApp extends StatelessWidget {
  const LiberationWarThemeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'সদস্য নিবন্ধন অ্যাপ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF006A4E), // গাঢ় সবুজ
        scaffoldBackgroundColor: const Color(0xFFF4F9F5), // হালকা সবুজ
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFF42A41), // লাল রঙ
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class Member {
  String name;
  String phone;
  String password;
  String designation;

  Member({
    required this.name,
    required this.phone,
    required this.password,
    this.designation = 'পদবি বরাদ্দহীন',
  });
}

List<Member> globalMemberList = [
  Member(name: 'রফিক আহমেদ', phone: '01711112233', password: '123', designation: 'মুক্তিযোদ্ধা কমান্ড'),
  Member(name: 'সালাম মিয়া', phone: '01922334455', password: '456', designation: 'সহ-যোদ্ধা'),
];

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _registerAndLogin() {
    if (_formKey.currentState!.validate()) {
      Member newMember = Member(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
      globalMemberList.add(newMember);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(currentUserName: newMember.name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সদস্য নিবন্ধন', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF006A4E),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF006A4E),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF42A41),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'জয় বাংলা, জয় বঙ্গবন্ধু',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF006A4E)),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'আপনার নাম',
                  prefixIcon: Icon(Icons.person, color: Color(0xFF006A4E)),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'অনুগ্রহ করে নাম লিখুন' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'মোবাইল নাম্বার',
                  prefixIcon: Icon(Icons.phone, color: Color(0xFF006A4E)),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'অনুগ্রহ করে মোবাইল নাম্বার লিখুন' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'পাসওয়ার্ড',
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF006A4E)),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.length < 4 ? 'পাসওয়ার্ড ন্যূনতম ৪ অক্ষরের হতে হবে' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF42A41),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _registerAndLogin,
                  child: const Text('নিবন্ধন করুন ও প্রবেশ করুন', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentUserName;
  const HomeScreen({Key? key, required this.currentUserName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006A4E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegistrationScreen()),
            );
          },
        ),
        title: const Text('সদস্য তালিকা ও হোম', style: TextStyle(color: Colors.white)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'admin') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminVerificationScreen()),
                ).then((_) => setState(() {}));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'whatsapp_info',
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('হোয়াটসঅ্যাপ এডমিন:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('01771062549', style: TextStyle(color: Color(0xFFF42A41), fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('নতুন সমস্যারা তাদের পদের জন্য এখানে যোগাযোগ করুন।', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Divider(),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'admin',
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings, color: Color(0xFF006A4E)),
                    SizedBox(width: 8),
                    Text('এডমিন প্যানেল লগইন'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: globalMemberList.length,
        itemBuilder: (context, index) {
          final member = globalMemberList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF42A41),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('মোবাইল: ${member.phone}'),
              trailing: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF006A4E),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  member.designation,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdminVerificationScreen extends StatefulWidget {
  const AdminVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AdminVerificationScreen> createState() => _AdminVerificationScreenState();
}

class _AdminVerificationScreenState extends State<AdminVerificationScreen> {
  final _passwordController = TextEditingController();

  void _verifyAdmin() {
    if (_passwordController.text == '1971') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ভুল এডমিন পাসওয়ার্ড! আবার চেষ্টা করুন।'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('এডমিন ভেরিফিকেশন', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF006A4E)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 80, color: Color(0xFFF42A41)),
            const SizedBox(height: 20),
            const Text('এডমিন প্যানেলে প্রবেশের জন্য পাসওয়ার্ড দিন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'এডমিন পাসওয়ার্ড',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006A4E)),
              onPressed: _verifyAdmin,
              child: const Text('লগইন', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  void _editDesignation(int index) {
    final controller = TextEditingController(text: globalMemberList[index].designation);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${globalMemberList[index].name}-এর পদবি নির্ধারণ'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'নতুন পদবি'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006A4E)),
            onPressed: () {
              setState(() {
                globalMemberList[index].designation = controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text('সংরক্ষণ করুন', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('এডমিন ম্যানেজমেন্ট প্যানেল', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFF42A41),
      ),
      body: ListView.builder(
        itemCount: globalMemberList.length,
        itemBuilder: (context, index) {
          final member = globalMemberList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('পদবি: ${member.designation}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF006A4E)),
                onPressed: () => _editDesignation(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
