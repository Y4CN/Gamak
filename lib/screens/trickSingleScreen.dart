import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrickSingleScreen extends StatefulWidget {
  const TrickSingleScreen({super.key});

  @override
  State<TrickSingleScreen> createState() => _TrickSingleScreenState();
}

class _TrickSingleScreenState extends State<TrickSingleScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .8);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: SliverAppBar(
                backgroundColor: GenerallColor.appBarBackGroundColor,
                toolbarHeight: 200,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 120, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: GenerallColor.primaryColor.withOpacity(.6),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.back,
                              color: GenerallColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/test2.jpg',
                        fit: BoxFit.cover,
                      ),
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                GenerallColor.primaryColor,
                              ],
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              stops: [.9, 1],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Title Trick',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                    'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.'),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(
            //       vertical: 10,
            //       horizontal: 10,
            //     ),
            //     height: 80,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(
            //         color: Colors.black54,
            //         width: 1,
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15),
            //       child: Row(
            //         children: const [
            //           CircleAvatar(
            //             radius: 30,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(
            //               right: 10,
            //             ),
            //             child: Text(
            //               'Author',
            //               style: TextStyle(
            //                 fontSize: 16,
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 25,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: const WormEffect(
                              dotColor: Colors.white,
                              activeDotColor: Colors.black,
                              dotHeight: 12,
                              dotWidth: 12,
                              type: WormType.thin),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'نظرات :‌',
                  style: TextStyle(fontSize: 20, fontFamily: 'vazirm'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey,
                        spreadRadius: -1,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              minRadius: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Name Commenter',
                              style: TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.pen,
                                  color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'commentcadadadadasd;agilahfgaiucasgigaifugiusajbkfvabiugffipowqipeiwqruqwyueiquewqporopwqtwe[t[worewpripouaposaoidafalkgjlah]]',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: 10),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 70),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            alignment: Alignment.center,
            child: TextField(
              onSubmitted: (value) {
                //TODO submit is HERE
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                labelText: 'نظر خودتون رو بنویسید',
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'vazirm',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
