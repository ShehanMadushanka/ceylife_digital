import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetailedSummaryView extends StatefulWidget {
  final ProductDetailEntity productDetail;

  const ProductDetailedSummaryView({Key key, this.productDetail})
      : super(key: key);

  @override
  _ProductDetailedSummaryViewState createState() =>
      _ProductDetailedSummaryViewState();
}

class _ProductDetailedSummaryViewState
    extends State<ProductDetailedSummaryView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: null,
        leadingWidth: 0,
        title: Text(
          'Ceylinco Life ' + widget.productDetail.productName,
          style: TextStyle(
            color: AppColors.textColorMaroon,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close,
                color: AppColors.primaryBackgroundColor, size: 40),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ImageGestures(
                      label: AppLocalizations.of(context)
                          .translate('pinch_to_zoom'),
                      icon: CeylifeIcons.ic_zoom,
                    ),
                  ),
                  Flexible(
                    child: ImageGestures(
                      label: AppLocalizations.of(context)
                          .translate('double_tap_for_default'),
                      icon: CeylifeIcons.ic_double_tap,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: PhotoView(
                filterQuality: FilterQuality.high,
                backgroundDecoration: BoxDecoration(color: Colors.white),
                loadingBuilder:
                    (BuildContext context, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return SizedBox.shrink();
                  return ImageLoadingIndicator(
                      loadingProgress: loadingProgress);
                },
                imageProvider:
                    NetworkImage(widget.productDetail.detailSummaryLink),
                enableRotation: false,
                disableGestures: false,
                initialScale: PhotoViewComputedScale.covered,
                maxScale: PhotoViewComputedScale.covered * 3,
                minScale: PhotoViewComputedScale.covered,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }
}

class ImageGestures extends StatelessWidget {
  final String label;
  final IconData icon;

  const ImageGestures({Key key, this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.newsItemButtonColor),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textColorMaroon,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
