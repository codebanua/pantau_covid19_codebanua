import 'package:coronamonitorapps/models/response_news.dart';
import 'package:coronamonitorapps/network/service_news.dart';
import 'package:flutter/foundation.dart';

class NewsChangeNotifier with ChangeNotifier {
  NewsChangeNotifier() {
    getHoakNews();
  }

  ServiceNews _service = ServiceNews();

  ResponseNews dataNews;
  bool _isFetching;

  bool get isFetching => _isFetching;

  Future<void> getHoakNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getHoakNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getKemenkesNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getKemenkesNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getDetikNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getDetikNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getLiputan6News() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getLiputan6News(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getKompasNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getKompasNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getTribunBjmNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getTribunBjmNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getKanalKlmNews() async {
    _isFetching = true;
    notifyListeners();
    dataNews = await _service.getKanalKlmNews(newsPage);
    _isFetching = false;
    notifyListeners();
  }

  int _newsPage = 1;

  int get newsPage => _newsPage;

  void resetPage() {
    _newsPage = 1;
  }

  void incNewsPage() {
    _newsPage++;
    notifyListeners();
  }

  void decNewsPage() {
    _newsPage--;
    notifyListeners();
  }
}
