<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class LoginCheck
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // if (!Auth::user()) {
        //     return redirect('/login');
        // }
        // if (Auth::check()) {
        //     return view('home');
        // }
        return $next($request);
    }
}
