import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dating_template/pages/home/index/search_dialog.dart';
import 'package:flutter_dating_template/wcao/kit/index.dart';
import 'package:flutter_dating_template/wcao/ui/theme.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'example_candidate_model.dart';
import 'example_card.dart';

class PageViewIndex extends StatefulWidget {
  const PageViewIndex({Key? key}) : super(key: key);

  @override
  State<PageViewIndex> createState() => _PageViewIndexState();
}

class _PageViewIndexState extends State<PageViewIndex> {
  List<String> swipers = [
    WcaoUtils.getRandomImage(),
    WcaoUtils.getRandomImage(),
    WcaoUtils.getRandomImage(),
    WcaoUtils.getRandomImage(),
  ];

  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map(ExampleCard.new).toList();

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width - 24;
    return Column(
      children: [
        AppBar(
          title: appBarTitle(),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () => Get.toNamed('/history-match'),
              child: Row(
                children: [
                  Center(
                    child: Text(
                      '匹配历史',
                      style: TextStyle(
                        color: WcaoTheme.base,
                        fontSize: WcaoTheme.fsBase,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 6, right: 12),
                    width: 64,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        avatar('/avatar/1.jpg'),
                        Positioned(left: 14, child: avatar('/avatar/2.jpg')),
                        Positioned(left: 28, child: avatar('/avatar/3.jpg')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Flexible(
          child: CardSwiper(
            controller: controller,
            cardsCount: cards.length,
            onSwipe: _onSwipe,
            onUndo: _onUndo,
            numberOfCardsDisplayed: 3,
            backCardOffset: const Offset(40, 40),
            padding: const EdgeInsets.all(24.0),
            cardBuilder: (
                context,
                index,
                horizontalThresholdPercentage,
                verticalThresholdPercentage,
                ) =>
            cards[index],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // FloatingActionButton(
              //   onPressed: controller.undo,
              //   child: const Icon(Icons.rotate_left),
              // ),
              FloatingActionButton(
                onPressed: () => controller.swipe(CardSwiperDirection.left),
                child: const Icon(Icons.close),
                backgroundColor: Colors.red,
                shape: CircleBorder(),
              ),
              FloatingActionButton(
                onPressed: () =>
                    controller.swipe(CardSwiperDirection.right),
                child: const Icon(Icons.check),
                backgroundColor: Colors.green,
                shape: CircleBorder(),
                // foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget appBarTitle() {
    return InkWell(
      onTap: () {
        /// 弹出search
        showModalBottomSheet(
          builder: (context) => const SearchDialog(),
          context: context,
          isScrollControlled: true,
        );
      },
      child: Row(children: [
        Text(
          '匹配条件',
          style: TextStyle(fontSize: WcaoTheme.fsBase),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: Transform.rotate(
            angle: -math.pi / 2,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: WcaoTheme.fsBase,
            ),
          ),
        ),
      ]),
    );
  }

  Container tag(String str) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      color: Colors.black.withValues(alpha: .46),
      child: Text(
        str,
        style: TextStyle(
          fontSize: WcaoTheme.fsSm,
          color: WcaoTheme.outline,
        ),
      ),
    );
  }

  Widget avatar(String url) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: WcaoTheme.outline),
        borderRadius: BorderRadius.circular(24),
      ),
      child: CircleAvatar(
        radius: 10,
        backgroundImage: NetworkImage(WcaoUtils.getRandomImage()),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
