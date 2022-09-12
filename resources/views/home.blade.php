<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Taratex</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@200;600&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="{{asset('css/all.css')}}">
    <link rel="stylesheet" href="{{asset('css/custom.css')}}">

</head>

<body>
    <div id="app">  
    @if(Auth::check())
        <mainapp :user ="{{Auth::user()}}"></mainapp>
        @else
        <login :user="false"></login>
        @endif
        
    </div>
    <script src="{{asset('js/app.js')}}"></script>
    <script src="{{asset('js/vendor.js')}}"></script>
    <script src="{{asset('js/admin.js')}}"></script>
</body>

</html>