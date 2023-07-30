import 'package:flutter/cupertino.dart';
import 'package:card_swiper/card_swiper.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> imageList;

  const ProductCarousel({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints(maxHeight: 450, maxWidth: 450),
        child: Swiper(
          itemBuilder: (context, index) {
            final image = imageList[index];
            return Image.network(
              'https://kids-zone-backend-v2.onrender.com$image',
              fit: BoxFit.fill,
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          itemCount: imageList.length,
          pagination: SwiperPagination(
            builder: SwiperCustomPagination(builder: (context, config) {
              return ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 50.0),
                child: Align(
                  alignment: Alignment.center,
                  child: DotSwiperPaginationBuilder(
                          color: const Color(0xff1f1f1f).withOpacity(0.1),
                          activeColor: const Color(0xff1f1f1f),
                          size: 10.0,
                          activeSize: 20.0)
                      .build(context, config),
                ),
              );
            }),
          ),
          control: const SwiperControl(
            color: Color(0xff1f1f1f),
          ),
        ));
  }
}
