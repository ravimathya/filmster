$(function () {
    let form = $('#movie-search');
    form.submit(function (e) {
        e.preventDefault();
        $.ajax({
                url: 'https://api.themoviedb.org/3/search/movie?api_key=12ce4e2bef2c5b2385bff21967591bd8',
                data: form.serialize()
            })
            .done(function (data) {
                displayMoives(data);
            });
    });

    function displayMoives(data) {
        let container = $("#movies");
        let htmlString = "";

        container.empty();
        let imageUrl = getBaseImageUrl();

        // debugger;
        if (data["results"].length == 0) {
            htmlString = `<div class="alert alert-danger text-center>" role="alert">No Data Found!</div>`;
        } else {
            data["results"].forEach(function (movie) {
                htmlString += ` <img src=${movie["poster_path"] == null ? "/assets/Image_Available.jpg" : imageUrl + "/" + movie["poster_path"]} data-id="${movie['id']}" class = "movie_poster text-center"/>
                                <p>${movie["title"]}</p>
                                <p>${movie["overview"]}</p>
                                <div id="movie_${movie.id}"></div>
                                <form id="rating-form" action="/reviews" method="POST">
                                    <input type="hidden" name="authenticity_token" value=${window._token} />
                                   <input type="hidden" name="tmdb_id" value=${movie["id"]} />
                                   <textarea name= "review[comment]" class="form-control" placeholder="Your movie review"/>
                                   <br />
                                   <input type="submit" class="btn btn-success pull-right" />
                                </form>`;
            });


        }

        container.append(htmlString);
    }
});

function getBaseImageUrl() {
    var url = "";
    var settings = {
        "async": false,
        "crossDomain": true,
        "url": "https://api.themoviedb.org/3/configuration?api_key=12ce4e2bef2c5b2385bff21967591bd8",
        "method": "GET",
        "header": {},
        "data": "{}"
    }
    $.ajax(settings).done(function (response) {
        url = response["images"]["base_url"] + response["images"]["poster_sizes"][3];
    });
    return url;
}

$(document).ready(function () {
    $('#movies').on('click', 'img.movie_poster', function (e) {
        e.preventDefault();

        let id = $(e.target).data('id');

        $.ajax({
                url: 'https://api.themoviedb.org/3/movie/' + id + '?',
                data: {
                    "api_key": "12ce4e2bef2c5b2385bff21967591bd8"
                }
            })
            .done(function (data) {
                displayMovie(data);
            })
    });

    function displayMovie(data) {
        let containers = $(`#movie_${data.id}`);
        let htmlStrings = "";
        containers.empty();
        htmlStrings = `<p>${data.genres.map(x => x.name)}</p>`;
        containers.append(htmlStrings);
        console.log(data)
    };
});