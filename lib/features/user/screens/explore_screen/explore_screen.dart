import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumo/features/diary/screens/user_diaries_list_view/widgets/user_info_chip/user_info_notifier.dart';
import 'package:rumo/features/user/controllers/search_users_controller.dart';
import 'package:rumo/features/user/repositories/follow_repository.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explorar'),
      ),
      body: Builder(
        builder: (context) {
          final loggedUserAsync = ref.watch(userInfoProvider);
          final followersAsync = ref.watch(searchUsersControllerProvider);
          if (followersAsync.isLoading || loggedUserAsync.valueOrNull == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (followersAsync.hasError) {
            log("Erro", error: followersAsync.error, stackTrace: followersAsync.stackTrace);
            return Center(
              child: Text(
                'Erro ao carregar seguidores: ${followersAsync.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          final follows = followersAsync.valueOrNull!;
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            itemCount: follows.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final follow = follows[index];
              return ListTile(
                title: Text(follow.user?.name ?? ''),
                trailing: FollowButton(
                  isFollowing: follow.isFollowing,
                  targetUserId: follow.user?.id,
                  userId: loggedUserAsync.valueOrNull!.uid,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  final String userId;
  final String? targetUserId;
  final bool isFollowing;
  const FollowButton({
    super.key,
    required this.userId,
    required this.targetUserId,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    if (isFollowing) {
      return FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () {
          if (targetUserId == null) return;
          FollowRepository().unfollowUser(userId, targetUserId!);
        },
        child: Text('Seguindo'),
      );
    }
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      onPressed: () {
        if (targetUserId == null) return;
        FollowRepository().followUser(userId, targetUserId!);
      },
      child: Text('Seguir'),
    );
  }
}