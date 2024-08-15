import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_infinitescroll/data/datasources/posts_api.dart';
import 'package:posts_infinitescroll/domain/entity/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        if (state.hasReachedMax) return;
        try {
          if (state.status == PostStatus.loading) {
            final posts = await PostsApi.getPosts(startIndex: 0, limit: 20);
            return emit(state.copyWith(
              status: PostStatus.success,
              posts: posts,
              // hasReachedMax: false,
            ));
          } else {
            final posts =
                await PostsApi.getPosts(startIndex: state.posts.length);
            posts.isEmpty
                ? emit(state.copyWith(
                    status: PostStatus.success,
                    hasReachedMax: true,
                  ))
                : emit(state.copyWith(
                    status: PostStatus.success,
                    posts: [...state.posts, ...posts],
                    // posts: List.of(state.posts)..addAll(posts),
                    hasReachedMax: false,
                  ));
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: PostStatus.error,
              errorMessage: "failed to fetch data",
            ),
          );
        }
      }
    });
  }
}
