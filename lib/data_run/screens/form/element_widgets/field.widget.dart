import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mass_pro/data_run/screens/form/element/form_element.dart';
import 'package:mass_pro/data_run/screens/form/element_widgets/form_widget_factory.dart';
import 'package:mass_pro/data_run/screens/form/hooks/register_dependencies.dart';

class FieldWidget extends HookWidget {
  FieldWidget({super.key, required this.element});

  final FieldInstance<dynamic> element;

  @override
  Widget build(BuildContext context) {
    final elementConfig = useState(element.properties);
    final requiredDependencies = element.requiredDependencies;
    useRegisterDependencies(element);

    if (elementConfig.value.hidden) {
      return SizedBox.shrink();
    }

    return Card(
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FieldFactory.fromType(element: element),
      ),
    );
  }
}
