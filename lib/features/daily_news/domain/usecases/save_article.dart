import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/daily_news/domain/entities/article.dart';
import 'package:my_playground/features/daily_news/domain/repository/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }

}