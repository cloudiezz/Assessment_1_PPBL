import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Registrasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const SimpleFormPage(),
    );
  }
}

class SimpleFormPage extends StatefulWidget {
  const SimpleFormPage({super.key});

  @override
  State<SimpleFormPage> createState() => _SimpleFormPageState();
}

class _SimpleFormPageState extends State<SimpleFormPage> {
  //  API 1: FormGroup Wadah atau container untuk semua form control
  FormGroup buildForm() {
    return FormGroup({
      // API 2: FormControl Membuat kontrol untuk setiap field input
      'name': FormControl<String>(
        //  API 3: Validators.required Memastikan field tidak boleh kosong
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        validators: [
          Validators.required,
          // API 4: Validators.email Memastikan format email benar
          Validators.email,
        ],
      ),
      'age': FormControl<int>(
        validators: [
          // API 5: Validators.number Memastikan input berupa angka
          Validators.number(),
          // API 6: Validators.min Memastikan nilai minimal 17 tahun
          Validators.min(17),
          //  API 7: Validators.max Memastikan nilai maksimal 100 tahun
          Validators.max(100),
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          //  API 8: Validators.minLength Memastikan password minimal 6 karakter
          Validators.minLength(6),
        ],
      ),
      'confirm': FormControl<String>(
        validators: [Validators.required],
      ),
      'agree': FormControl<bool>(
        value: false,
        // API 9: Validators.requiredTrue Memastikan checkbox harus dicentang
        validators: [Validators.requiredTrue],
      ),
    }, validators: [
      // API 10: Validators.mustMatch Memastikan password dan konfirmasi password sama
      Validators.mustMatch('password', 'confirm'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text(
          'Form Registrasi',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.pink.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ReactiveFormBuilder(
        //  API 11: ReactiveFormBuilder Widget builder yang menghubungkan form dengan UI
        form: buildForm,
        builder: (context, form, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header sederhana
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.assignment, color: Colors.pink.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Isi data diri dengan benar',
                            style: TextStyle(
                              color: Colors.pink.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // API 12: ReactiveTextField Widget input teks yang terhubung ke FormControl
                          ReactiveTextField(
                            formControlName: 'name',
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              hintText: 'Masukkan nama Anda',
                              prefixIcon: Icon(Icons.person_outline,
                                  color: Colors.pink.shade400, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                                  'Nama wajib diisi',
                            },
                          ),
                          const SizedBox(height: 14),

                          ReactiveTextField(
                            formControlName: 'email',
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'contoh@email.com',
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.pink.shade400, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                                  'Email wajib diisi',
                              ValidationMessage.email: (_) =>
                                  'Format email tidak valid',
                            },
                          ),
                          const SizedBox(height: 14),

                          ReactiveTextField(
                            formControlName: 'age',
                            decoration: InputDecoration(
                              labelText: 'Umur',
                              hintText: 'Minimal 17 tahun',
                              prefixIcon: Icon(Icons.cake_outlined,
                                  color: Colors.pink.shade400, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validationMessages: {
                              ValidationMessage.number: (_) =>
                                  'Harus berupa angka',
                              ValidationMessage.min: (_) =>
                                  'Minimal umur 17 tahun',
                              ValidationMessage.max: (_) =>
                                  'Maksimal umur 100 tahun',
                            },
                          ),
                          const SizedBox(height: 14),

                          ReactiveTextField(
                            formControlName: 'password',
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Minimal 6 karakter',
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.pink.shade400, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            obscureText: true,
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                                  'Password wajib diisi',
                              ValidationMessage.minLength: (_) =>
                                  'Minimal 6 karakter',
                            },
                          ),
                          const SizedBox(height: 14),

                          ReactiveTextField(
                            formControlName: 'confirm',
                            decoration: InputDecoration(
                              labelText: 'Konfirmasi Password',
                              hintText: 'Masukkan password yang sama',
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.pink.shade400, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.pink.shade400),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            obscureText: true,
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                                  'Konfirmasi wajib diisi',
                              ValidationMessage.mustMatch: (_) =>
                                  'Password tidak cocok',
                            },
                          ),
                          const SizedBox(height: 14),

                          // API 13: ReactiveCheckbox Widget checkbox yang terhubung ke FormControl
                          Row(
                            children: [
                              ReactiveCheckbox(
                                formControlName: 'agree',
                                activeColor: Colors.pink.shade600,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Saya menyetujui syarat & ketentuan',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tombol
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // API 14: markAllAsTouched  Menandai semua field sudah disentuh (memunculkan error)
                            form.markAllAsTouched();
                            // API 15: form.valid Mengecek apakah semua field sudah valid
                            if (form.valid) {
                              //  API 16: form.value Mengambil semua data dari form
                              final data = form.value;
                              _showDialog(data);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.pink.shade500,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Registrasi'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            //  API 17: form.reset Mengosongkan semua field form
                            form.reset();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.pink.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(color: Colors.pink.shade600),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Indikator validasi sederhana
                  if (!form.valid)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '⚠️ Form belum lengkap, periksa kembali',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.pink.shade400,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.pink.shade500, size: 24),
            const SizedBox(width: 8),
            const Text('Berhasil!'),
          ],
        ),
        content: Text('Halo ${data['name']}, selamat datang!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.pink.shade600),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}