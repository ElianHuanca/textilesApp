import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../providers/providers.dart';


class UsuarioScreen extends StatelessWidget {
  const UsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Screen1(
          widget: [_PerfilForm()],
          title: 'Editar Perfil',
          isGridview: false,          
        ));
  }
}

class _PerfilForm extends ConsumerWidget {
  const _PerfilForm();

  @override
  Widget build(context, WidgetRef ref) {
    ref.read(loginFormProvider.notifier).userCallback;
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [          
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Nombre',   
            initialValue: loginForm.nombre,
            onChanged: ref.read(loginFormProvider.notifier).onNombreChange,          
          ),
          CustomTextFormField(
            label: 'Correo',
            initialValue: loginForm.email.value,
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Nueva Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            onFieldSubmitted: (_) =>
                ref.read(loginFormProvider.notifier).onFormSubmit(),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomFilledButton(
                  text: 'Actualizar',
                  buttonColor: Colors.black,
                  onPressed: loginForm.isPosting
                      ? null
                      : ref.read(loginFormProvider.notifier).onFormSubmit)),          
        ],
      ),
    );
  }
}
