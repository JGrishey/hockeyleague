module CommentsHelper
    def display_likes_comment(comment)
        votes = comment.votes_for.up
        return list_likers_comment(votes) if votes.count <= 8
        count_likers_comment(votes)
    end
    
    def like_form_comment(comment)
        if current_user.voted_for? comment
            return link_to "<img class='like-thumbs' id='like-button-comment-#{comment.id}' src='https://feathericons.com/node_modules/feather-icons/dist/icons/thumbs-down.svg'/>".html_safe, dislike_subforum_post_comment_path(comment.post.subforum, comment.post, comment), remote: true
        else
            return link_to "<img class='like-thumbs' id='like-button-comment-#{comment.id}' src='https://feathericons.com/node_modules/feather-icons/dist/icons/thumbs-up.svg'/>".html_safe, like_subforum_post_comment_path(comment.post.subforum, comment.post, comment), remote: true
        end
    end
    
    private
    
    def list_likers_comment(votes)
        user_names = []
        unless votes.blank?
            votes.voters.each do |voter|
                user_names.push(link_to voter.user_name,
                                    profile_path(voter.user_name),
                                    class: 'user-name')
            end
            user_names.to_sentence.html_safe + like_plural_comment(votes)
        end
    end
    
    def count_likers_comment(votes)
        vote_count = votes.size
        vote_count.to_s + ' likes'
    end
    
    def like_plural_comment(votes)
        return ' like this' if votes.count > 1
        ' likes this'
    end
end