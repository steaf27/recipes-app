@extends('layouts.app')

@section('content')

@if(session('success'))

<div class="alert alert-success alert-dismissible fade show">

    {{ session('success') }}

    <button
        type="button"
        class="btn-close"
        data-bs-dismiss="alert">
    </button>

</div>

@endif

<div class="hero">

    <div class="row align-items-center">

        <div class="col-md-8">

            <h2 class="page-title">
                🍽 Daftar Resep
            </h2>

            <p class="text-muted">
                Kelola dan simpan resep favoritmu.
            </p>

        </div>

        <div class="col-md-4 text-md-end">

            <a
                href="/recipes/create"
                class="btn btn-light">

                + Tambah Resep

            </a>

        </div>

    </div>

</div>

<div class="mb-4">

    <input
        type="text"
        id="searchRecipe"
        class="form-control search-box"
        placeholder="🔍 Cari resep...">

</div>

@if($recipes->count())

<div class="row" id="recipeContainer">

    @foreach($recipes as $recipe)

    <div class="col-lg-4 col-md-6 mb-4 recipe-item">

        <div class="card recipe-card h-100">

            @if($recipe->image)

            <img
                src="{{ asset('storage/'.$recipe->image) }}"
                class="card-img-top"
                style="
                    height:220px;
                    object-fit:cover;
                ">

            @endif

            <div class="card-body">

                <h5 class="fw-bold text-primary">

                    🍽 {{ $recipe->title }}

                </h5>

                <hr>

                <div class="d-grid">

                    <a
                        href="/recipes/{{ $recipe->id }}"
                        class="btn btn-purple">

                        👁 Lihat Detail

                    </a>

                </div>

            </div>

            <div class="card-footer bg-white border-0">

                @if(auth()->id() == $recipe->user_id)

                <a
                    href="/recipes/{{ $recipe->id }}/edit"
                    class="btn btn-warning btn-sm">

                    📝 Edit

                </a>

                <form
                    action="/recipes/{{ $recipe->id }}"
                    method="POST"
                    class="d-inline">

                    @csrf
                    @method('DELETE')

                    <button
                        type="submit"
                        onclick="return confirm('Yakin ingin menghapus resep ini?')"
                        class="btn btn-danger btn-sm">

                        🗑 Hapus

                    </button>

                </form>

                @endif

            </div>

        </div>

    </div>

    @endforeach

</div>

@else

<div class="alert alert-info">

    Belum ada resep.

</div>

@endif

<script>

const searchInput =
    document.getElementById('searchRecipe');

searchInput.addEventListener(
    'keyup',
    function() {

        let keyword =
            this.value.toLowerCase();

        let recipes =
            document.querySelectorAll('.recipe-item');

        recipes.forEach(function(item){

            let text =
                item.innerText.toLowerCase();

            if(text.includes(keyword)){

                item.style.display='';

            }else{

                item.style.display='none';
            }
        });
    }
);

</script>

@endsection