import 'package:Caship/providers/terms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsScreen extends StatefulWidget {
  static const routeName = '/terms';

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _isLoading = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TermsProvider>(context, listen: false).loadTerms().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final termProvider = Provider.of<TermsProvider>(context);
    final textTerms = termProvider.termsandconditions;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Terminos y condiciones',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    textTerms,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
