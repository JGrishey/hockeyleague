module PostsHelper
    def display_likes(post)
        votes = post.votes_for.up
        return list_likers(votes) if votes.count <= 8
        count_likers(votes)
    end
    
    def like_form(post)
        if current_user.voted_for? post
            return link_to "<img class='like-thumbs' id='like-button-post-#{post.id}' src='https://feathericons.com/node_modules/feather-icons/dist/icons/thumbs-down.svg'/>".html_safe, dislike_subforum_post_path(post.subforum, post), remote: true
        else
            return link_to "<img class='like-thumbs' id='like-button-post-#{post.id}' src='https://feathericons.com/node_modules/feather-icons/dist/icons/thumbs-up.svg'/>".html_safe, like_subforum_post_path(post.subforum, post), remote: true
        end
    end
    
    private
    
    def list_likers(votes)
        user_names = []
        unless votes.blank?
            votes.voters.each do |voter|
                user_names.push(link_to voter.user_name,
                                    profile_path(voter.user_name),
                                    class: 'user-name')
            end
            user_names.to_sentence.html_safe + like_plural(votes)
        end
    end
    
    def count_likers(votes)
        vote_count = votes.size
        vote_count.to_s + ' likes'
    end
    
    def like_plural(votes)
        return ' like this' if votes.count > 1
        ' likes this'
    end
end