import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StepsDialogWidget extends StatelessWidget {
  const StepsDialogWidget({
    Key? key,
  }) : super(key: key);

  Future show(BuildContext context) {
    return showDialog(context: context, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, minHeight: 400),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stepper(
                onStepContinue: () {
                  Modular.to.navigate('/edit-cras/');
                  Modular.to.pop();
                },
                onStepCancel: () {
                  Modular.to.pop();
                },
                currentStep: 3,
                steps: [
                  Step(
                    title:
                        const Text('Inserir Curva de Retenção de Água do Solo'),
                    content: Column(
                      children: const [],
                    ),
                    state: StepState.indexed,
                  ),
                  Step(
                    title: const Text('Inserir Dados do Solo'),
                    content: Column(
                      children: const [],
                    ),
                    state: StepState.indexed,
                  ),
                  Step(
                    title: const Text(
                        'Inserir Dados do Cultura e do Sistema de Irrigação'),
                    content: Column(
                      children: const [],
                    ),
                  ),
                  Step(
                    title: const Text('Informar Leitura do Tensiômetro'),
                    content: Column(
                      children: const [],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    '*Não se esqueça de avaliar o aplicativo, é muito importante para finalização desse trabalho.',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    );
  }
}
