
import 'package:flutter/widgets.dart';
import 'package:random_user/bloc/base.dart';

class MyBlocProvider<T extends BaseBloc> extends StatefulWidget
{
  MyBlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _MyBlocProviderState<T> createState() => _MyBlocProviderState<T>();

  static T of<T extends BaseBloc>(BuildContext context)
  {
    MyBlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider?.bloc;
  }
}

class _MyBlocProviderState<T> extends State<MyBlocProvider<BaseBloc>>
{
  @override
  void dispose()
  {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.child;
  }
}
