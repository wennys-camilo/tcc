import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/core/presentation/themes/app_theme.dart';
import 'custom_text_button_widget.dart';

class ShowDialogWidget extends StatelessWidget {
  final String bodyText;
  final bool? barrierDismissible;
  final VoidCallback? action;
  const ShowDialogWidget({
    Key? key,
    this.barrierDismissible,
    this.action,
    required this.bodyText,
  }) : super(key: key);

  Future show(BuildContext context) {
    return showDialog(
        barrierDismissible: barrierDismissible ?? true,
        context: context,
        builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 45, vertical: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(minHeight: 100),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              bodyText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.colors.primary,
                    const Color(0xff029670),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: Column(
                children: [
                  CustomTextButtonWidget(
                    text: 'OK',
                    onPressed:
                        action != null ? action! : () => Modular.to.pop(),
                    backgroundcolor: Colors.green,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
