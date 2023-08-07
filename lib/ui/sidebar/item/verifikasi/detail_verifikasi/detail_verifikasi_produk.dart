import 'package:flutter/material.dart';

import '../../../../../common/color_value.dart';

class DetailVerifikasiProduk extends StatefulWidget {
  const DetailVerifikasiProduk({super.key});

  @override
  State<DetailVerifikasiProduk> createState() => _DetailVerifikasiProdukState();
}

class _DetailVerifikasiProdukState extends State<DetailVerifikasiProduk> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail Verifikasi Produk',
            style: textTheme.headline6!.copyWith(
              color: ColorValue.neutralColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            )
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1598030304671-5aa1d6f21128?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHZlZ2V0YWJsZXN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60', fit: BoxFit.cover, width: 300, height: 300,),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sayur Bayam',
                                style: textTheme.headline6!.copyWith(
                                  color: ColorValue.neutralColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisi eget nunc ultricies aliquet. Sed vitae nisi eget nunc ultricies aliquet. Sed vitae nisi eget nunc ultricies aliquet.",
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.neutralColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                'Rp. 10.000',
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    "Kategori :",
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFFE5F4E3),
                                    ),
                                    child: Text(
                                      'Sayuran',
                                      style: textTheme.bodyText1!.copyWith(
                                        color: ColorValue.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    "List Variant :",
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Row(
                                    children: [
                                      chipVarian("1/KG"),
                                      const SizedBox(width: 5,),
                                      chipVarian("2/KG"),
                                      const SizedBox(width: 5,),
                                      chipVarian("3/KG"),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DetailVerifikasiProduk()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ColorValue.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
                          ),
                          child: Text(
                            'Verifikasi',
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chipVarian(String textVarian){
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorValue.neutralColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        textVarian,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ColorValue.neutralColor,
        ),
      ),
    );
  }
}
