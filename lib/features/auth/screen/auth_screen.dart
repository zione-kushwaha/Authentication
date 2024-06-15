import 'package:country_picker/country_picker.dart';
import 'package:day2/features/auth/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/snackbar.dart';
import '../../../common/widgets/widget.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth-screen';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Country? _selected;
  final TextEditingController _phoneController = TextEditingController();
  
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('verify  your number'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.withOpacity(0.4)),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        setState(() {
                          _selected = country;
                          // _phoneController.text = '+${country.phoneCode}${_phoneController.text} ';
                        });
                      },
                    );
                  },
                  child: const Text('Select Country', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (_selected != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${_selected!.flagEmoji} ',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Enter Phone Number',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              SizedBox(
                width: size.width * 0.5,
                child: bottomWidget(
                  text: 'Send  OTP',
                  onPressed: () {
                    print('phone number: ${_phoneController.text}');
                    if(_selected != null && _phoneController.text.isNotEmpty){
                     ref.read(AuthControllerProvider).signInWithPhoneNumber(context:  context,
                   phoneNumber: '+${_selected!.phoneCode}${_phoneController.text.trim()}');}else{
                      showCustomSnackBar(context, 'Please select country and enter phone number');  
                   }
                    }
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/phoneNumber.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}