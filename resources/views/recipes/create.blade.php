@extends('layouts.app')

@section('content')

<div class="card recipe-card">

    <div class="card-body p-4">

        <h2 class="page-title mb-4" style="color: #673AB7;">

            Tambah Resep

        </h2>

        <form
            action="/recipes"
            method="POST"
            enctype="multipart/form-data">

            @csrf

            <div class="mb-3">

                <label>Judul Resep</label>

                <input
                    type="text"
                    name="title"
                    class="form-control">

            </div>

            <div class="mb-3">

                <label>Deskripsi</label>

                <textarea
                    name="description"
                    rows="4"
                    class="form-control"></textarea>

            </div>

            <div class="mb-3">

    <label>Bahan-bahan</label>

    <textarea
        id="ingredients"
        name="ingredients"
        class="form-control auto-number"
        rows="5"
        placeholder="Ketik bahan lalu tekan Enter"></textarea>

</div>

<div class="mb-3">

    <label>Alat</label>

    <textarea
        id="tools"
        name="tools"
        class="form-control auto-number"
        rows="5"
        placeholder="Ketik alat lalu tekan Enter"></textarea>

</div>

<div class="mb-3">

    <label>Langkah-langkah</label>

    <textarea
        id="steps"
        name="steps"
        class="form-control auto-number"
        rows="8"
        placeholder="Ketik langkah lalu tekan Enter"></textarea>

</div>

            <div class="mb-3">

                <label>Foto Resep</label>

                <input
                    type="file"
                    name="image"
                    class="form-control"
                    onchange="previewImage(event)">

            </div>

            <img
                id="preview"
                style="
                    width:100%;
                    max-height:250px;
                    object-fit:cover;
                    display:none;
                    border-radius:15px;
                    margin-bottom:15px;
                ">

            <button
                type="submit"
                class="btn btn-purple">

                Simpan Resep

            </button>

        </form>

    </div>

</div>

<script>

function previewImage(event){

    const preview =
        document.getElementById('preview');

    preview.src =
        URL.createObjectURL(
            event.target.files[0]
        );

    preview.style.display =
        'block';
}

</script>

<script>

document
.querySelectorAll('.auto-number')
.forEach(textarea => {

    textarea.addEventListener(
        'keydown',
        function(e){

            if(e.key === 'Enter'){

                e.preventDefault();

                let lines =
                    this.value
                    .split('\n')
                    .filter(
                        line => line.trim() !== ''
                    );

                let next =
                    lines.length + 1;

                this.value +=
                    '\n' + next + '. ';
            }
        }
    );

    textarea.addEventListener(
        'focus',
        function(){

            if(this.value.trim() === ''){

                this.value = '1. ';
            }
        }
    );

});

</script>

@endsection