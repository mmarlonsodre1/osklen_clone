import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osklen/app/modules/home/model/menu_model.dart';
import 'package:osklen/components/menu/menu_item.dart';
import 'package:sizer/sizer.dart';

class TopMenu extends StatefulWidget {
  const TopMenu({Key? key}) : super(key: key);

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  final List<MenuModel> menuList = [
    MenuModel('Osklen AG',Colors.red),
    MenuModel('men',Colors.white),
    MenuModel('women',Colors.white),
    MenuModel('shoes',Colors.white),
    MenuModel('presentes',Colors.white),
    MenuModel('e_sustentabilidade',Colors.white),
    MenuModel('outlet',Colors.red),
  ];

  final List<IconData> menuIconList = [
    Icons.search, Icons.favorite_border,
    Icons.location_on_outlined, Icons.person_off_sharp,
    Icons.shopping_cart_outlined,
  ];
  final List<Color> menuColorList = [
    const Color(0xFF333333).withOpacity(0.1), Colors.black
  ];
  var isBlackMenu = false;
  var showSubMenu = false;
  var blockMenu = false;

  final List<String> subMenuTitleList = [
    'sale', 'roupas', 'acessórios', 'destaques'
  ];
  final List<String> subMenuSaleRoupasList = [
    'ver todos', 't-shirt', 'regatas', 'calças', 'polos', 'camisas', 'casacos'
  ];
  final List<String> subMenuAcessoriosList = [
    'shoes', 'bolsas', 'acessórios', 'sunglasses'
  ];
  final List<String> subMenuDestaquesList = [
    'destaques', 'new arrivals', 'colors brought to life'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          onHover: (value) {
            setState(() {
              isBlackMenu = value;
            });
          },
          child: Container(
            color: menuColorList[isBlackMenu || blockMenu ? 1 : 0],
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 3.w, right: 3.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SvgPicture.asset(
                      'assets/images/img_logo.svg',
                      semanticsLabel: 'Osklen',
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    height: 4.8.h,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: menuList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            onHover: (value) {
                              if (!blockMenu) {
                                setState(() { showSubMenu = value; });
                              }
                            },
                            child: Column(
                              children: [
                                AppMenuItem(model: menuList[index],),
                                SizedBox(height: 1.h,)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => SizedBox(width: 1.w,)
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SizedBox(
                      height: 3.h,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: menuIconList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Icon(menuIconList[index]),
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(width: 1.w,)
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      'BR',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 4.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: showSubMenu ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: showSubMenu ? InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                blockMenu = value;
                showSubMenu = value;
              });
            },
            child: Container(
              constraints: BoxConstraints(
                  minHeight: 1, maxHeight: 38.h,
                  minWidth: 100.w
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 5.h),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subMenuTitleList.length,
                    separatorBuilder: (BuildContext context, int index) => SizedBox(width: 2.w,),
                    itemBuilder: (BuildContext context, int index) {
                      var list = [];
                      if (index == 0) {
                        list = subMenuSaleRoupasList;
                      } else if (index == 1) {
                        list = subMenuSaleRoupasList;
                      } else if (index == 2) {
                        list = subMenuAcessoriosList;
                      } else if (index == 3) {
                        list = subMenuDestaquesList;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subMenuTitleList[index],
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w900,
                              fontSize: 2.5.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Container(
                            constraints: BoxConstraints(
                                minHeight: 1, maxHeight: 26.h,
                                minWidth: 1, maxWidth: 10.w
                            ),
                            child: ListView.separated(
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int currentIndex) {
                                return AppMenuItem(
                                  model: MenuModel(
                                      list[currentIndex],
                                      Colors.black,
                                  )..fontWeight = FontWeight.w500,
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 1.h,),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
          ) : const SizedBox(),
        ),
      ],
    );
  }
}
