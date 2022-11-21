import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitopatologia_app/view/fitopatologyInfo.view.dart';
import 'package:fitopatologia_app/view/fitopatologyInfoCatalog.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CatalogItem extends StatelessWidget {
  List<String> doenca;
  CatalogItem({required this.doenca});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, // error
            MaterialPageRoute(
          builder: (BuildContext context) {
            return FitopatolofyInfoCatalog(doenca: doenca);
          },
        ));
      },
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(135, 0, 0, 0),
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                      imageUrl: doenca[3],
                      fit: BoxFit.cover,
                      height: size.height * 0.20,
                      width: size.width * 0.3,
                      placeholder: (context, url) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(25, 50, 25, 50),
                          child: CircularProgressIndicator.adaptive(),
                        );
                      })),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.04),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doenca[0],
                          style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Text(
                            doenca[1],
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: size.width * 0.04,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
