import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recuperar el valor d''un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Controlador que nos permite leer (y modificar) el texto del TextField
  final myController = TextEditingController();

  @override
  void dispose() {
    // Liberamos el controlador al destruir la pantalla para no gastar memoria
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // Antes aquí había un TextField directamente.
        // El body solo admite UN widget, así que usamos un Column
        // para poder meter varios (el TextField y el botón) apilados en vertical.
        child: Column(
          children: [
            // El campo de texto de antes, sin cambios
            TextField(
              controller: myController,
            ),
            const SizedBox(height: 20),

            // Botón con borde. Es el que abre el diálogo.
            // El diálogo no se "coloca" en pantalla; lo abre un evento como este.
            OutlinedButton(
              // onPressed: lo que se ejecuta al pulsar el botón
              onPressed: () {
                // showDialog: función de Flutter que muestra un diálogo
                // por encima de la pantalla actual
                showDialog(
                  // context: le dice a Flutter sobre qué pantalla mostrarlo
                  context: context,

                  // builder: función que construye el contenido del diálogo.
                  // Fíjate que recibe su propio "context", distinto del de fuera.
                  builder: (BuildContext context) {
                    // SimpleDialog: diálogo con un título y una lista de opciones
                    return SimpleDialog(
                      // Título que aparece arriba en el diálogo
                      title: const Text('Selecciona una opcio'),

                      // Lista de widgets que van dentro del diálogo
                      children: [
                        // SimpleDialogOption: una opción pulsable de la lista
                        SimpleDialogOption(
                          onPressed: () {
                            // Cierra el diálogo (lo saca de la pila de pantallas)
                            Navigator.of(context).pop();
                          },
                          // Texto visible de la opción
                          child: const Text('Opcio 1'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Opcio 2'),
                        ),
                      ],
                    );
                  },
                );
              },
              // Texto que se ve dentro del botón
              child: const Text('SimpleDialog'),
            ),
            //Aqui va el AlertDialog
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: const Text('Alerta'),
                          content: const Text('Alerta: No fagis clic al boto'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              child: const Text('Ok'),
                            )
                          ],
                        );
                      },
                  );
                },
              child: const Text('AlertDialog'),
            ),
            //Aqui estara el ShowSnackBar
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Aixo es un SnackBar'),
                        duration: Duration(seconds: 3),
                    )
                  );
                },
                child: const Text('SnackBar')
            ),
            //Aqui estara el ShowModalButtonSheet
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container (
                          decoration: const BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget> [
                                const Text('ModalBottomSheet'),
                                ElevatedButton(
                                    child: const Text('Tancar BottomSheet'),
                                    onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                            ),
                          )
                        );
                      },
                  );
                },
                child: const Text('ModalButtonSheet'))
          ],
        ),
      ),
    );
  }
}