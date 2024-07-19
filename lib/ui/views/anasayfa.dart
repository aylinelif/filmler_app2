
import 'package:filmler_app/ui/cubit/anasayfa_cubit.dart';
import 'package:filmler_app/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/filmler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

 @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().filmleriyukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filmler"),
      ),
      body: BlocBuilder<AnasayfaCubit,List<Filmler>>(

        builder: (context, filmlerListesi) {
          if (filmlerListesi.isNotEmpty) {

            return GridView.builder(
              itemCount: filmlerListesi!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.8,
              ),
              itemBuilder: (context, indeks) {
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: (){ //tıklanılabilir olmayı sağlıyor buttona gelip option+enter yaparak wrap widgetı seçiyosun sonra düzenliyosun
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(film:film)));
                  },
                  child: Card(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("resimler/${film.resim}"),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${film.fiyat}₺",style: TextStyle(fontSize: 24),),
                            ElevatedButton(onPressed: (){
                              print("${film.ad} sepete eklendi");
                            }, child: const Text("sepet"))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(); // Veri yoksa boş sayfa döndürür.
          }
        },
      ),
    );
  }
}
