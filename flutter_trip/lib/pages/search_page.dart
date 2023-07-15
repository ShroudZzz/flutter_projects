import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import 'package:flutter_trip/widget/search_bar.dart' as CSearchBar;

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage({super.key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;
  
  @override
  void initState() {
    if (widget.keyword != null) {
      _onTextChange(widget.keyword!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder( // ListView 必须要有高度 Expanded
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  }),
            ),
          )
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
              padding: const EdgeInsets.only(top: 25),
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: CSearchBar.SearchBar(
                hideLeft: widget.hideLeft,
                defaultText: widget.keyword,
                hint: widget.hint,
                speakClick: _jumpToSpeak,
                rightButtonClick: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                leftButtonClick: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                },
                onChanged: _onTextChange,
              )),
        )
      ],
    );
  }

  void _jumpToSpeak() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SpeakPage();
    }));
  }

  void _onTextChange(String value) {
    keyword = value;
    if (value.isEmpty) {
      setState(() {
        searchModel = null;
      });
      return;
    }

    String url = widget.searchUrl + value;
    SearchDao.fetch(url, value).then((value) {
      if (value.keyword == keyword) {
        setState(() {
          searchModel = value;
        });
      }
    }).catchError( (e) {

    });
  }

  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem item = searchModel!.data![position];
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Image(
                  height: 26,
                  width: 26,
                  image: AssetImage(_typeImage(item.type))),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 5),
                    child: item.price == null && item.star == null ? null : _subTitle(item)
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _title(SearchItem item) {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel!.keyword!));
    spans.add(TextSpan(
        text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}',
        style: const TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = const TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item.price ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ${item.star ?? ''}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }
}
