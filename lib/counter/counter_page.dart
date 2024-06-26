import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weartest/cubit/counter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                if (context.read<CounterCubit>().state < 10) {
                  context.read<CounterCubit>().increment();
                } else {
                  Fluttertoast.showToast(msg: "El contador debe ser mayor que 10");
                }
              },
              child: const Icon(Icons.add)),
            const SizedBox(height: 5,),
            const CounterText(),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                if (context.read<CounterCubit>().state > -10) {
                  context.read<CounterCubit>().decrement();
                } else {
                  Fluttertoast.showToast(msg: "El contador debe ser menor que -10");
                }
              },
              child: const Icon(Icons.remove)),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () => context.read<CounterCubit>().reset(),
              child: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}


class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayMedium);
  }
}
