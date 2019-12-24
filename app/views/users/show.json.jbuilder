json.id @user.id
json.username @user.username
json.introduction @user.introduction
json.avatar_url @user.avatar

json.reviews do
    json.array! @user.reviews do |review|
        json.movie review.movie, :title, :id, :release_date, :popularity, :tmdb_id, :poster
        json.commnet review.comment
    end
end