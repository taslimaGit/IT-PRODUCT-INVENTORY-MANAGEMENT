<?php

use App\Department;
use App\Http\Middleware\LoginCheck;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::prefix('app')->middleware([LoginCheck::class])->group(function () {

    // User 
    Route::get('/get-user', 'UserController@index');
    Route::post('/store-user', 'UserController@create');
    Route::post('/update-user', 'UserController@update');
    Route::post('/delete-user', 'UserController@destroy');
    Route::get('/get-all-role-user', 'UserController@get_all_role_user');
    Route::post('/login-check', 'UserController@login_check');
    Route::get('/logout', 'UserController@logout');
});

//Deashboard
Route::get('/app/item-product', 'AdminController@all_items_products');

// Department 
Route::get('/app/get-all-department', 'DepartmentController@allDepartment');
Route::get('/app/get-department', 'DepartmentController@index');
Route::post('/app/store-department', 'DepartmentController@create');
Route::post('/app/update-department', 'DepartmentController@update');
Route::post('/app/delete-depertment', 'DepartmentController@destroy');

//Designation
Route::get('/app/get-all-designation', 'DesignationController@allDesignation');
Route::get('/app/get-designation', 'DesignationController@index');
Route::post('/app/store-designation', 'DesignationController@create');
Route::post('/app/update-designation', 'DesignationController@update');
Route::post('/app/delete-designation', 'DesignationController@destroy');

// Item 
Route::get('/app/get-all-item', 'ItemController@allItem');
Route::get('/app/get-item', 'ItemController@index');
Route::post('/app/store-item', 'ItemController@create');
Route::post('/app/update-item', 'ItemController@update');
Route::post('/app/delete-item', 'ItemController@destroy');

// Attribute 
Route::get('/app/get-all-attribute', 'ProductAttributeController@allAttribute');
Route::get('/app/get-attribute', 'ProductAttributeController@index');
Route::post('/app/store-attribute', 'ProductAttributeController@create');
Route::post('/app/update-attribute', 'ProductAttributeController@update');
Route::post('/app/delete-attribute', 'ProductAttributeController@destroy');

// Brand 
Route::get('/app/get-all-brand', 'BrandController@allBrand');
Route::get('/app/get-brand', 'BrandController@index');
Route::post('/app/store-brand', 'BrandController@create');
Route::post('/app/update-brand', 'BrandController@update');
Route::post('/app/delete-brand', 'BrandController@destroy');

// Seller 
Route::get('/app/get-all-seller', 'SellerController@allSeller');
Route::get('/app/get-seller', 'SellerController@index');
Route::post('/app/store-seller', 'SellerController@create');
Route::post('/app/update-seller', 'SellerController@update');
Route::post('/app/delete-seller', 'SellerController@destroy');

// Warranty 
Route::get('/app/get-all-period', 'WarrantyController@allPeriod');
Route::get('/app/get-period', 'WarrantyController@index');
Route::post('/app/store-period', 'WarrantyController@create');
Route::post('/app/update-period', 'WarrantyController@update');
Route::post('/app/delete-period', 'WarrantyController@destroy');

// Client 
Route::get('/app/get-all-department-client', 'ClientController@get_all_department_client');
Route::get('/app/get-all-designation-client', 'ClientController@get_all_designation_client');
Route::get('/app/get-all-client', 'ClientController@allClient');
Route::get('/app/get-client', 'ClientController@index');
Route::post('/app/store-client', 'ClientController@create');
Route::post('/app/update-client', 'ClientController@update');
Route::post('/app/active-status-change-client', 'ClientController@active_status_change_client');
Route::post('/app/delete-client', 'ClientController@destroy');

// Product 
Route::get('/app/get-all-attribute-product', 'ProductController@get_all_attribute_product');
Route::get('/app/get-all-item-product', 'ProductController@get_all_item_product');
Route::get('/app/get-all-seller-product', 'ProductController@get_all_seller_product');
Route::get('/app/get-all-brand-product', 'ProductController@get_all_brand_product');
Route::get('/app/get-all-period-product', 'ProductController@get_all_period_product');
Route::post('/app/store-product', 'ProductController@create');
Route::get('/app/get-product', 'ProductController@index');
Route::post('/app/update-product', 'ProductController@update');
Route::post('/app/delete-product', 'ProductController@destroy');
Route::get('/app/get-all-product', 'ProductController@allProduct');

//Assign
Route::get('/app/get-product-assign', 'ClientProductController@get_product_assign');
Route::get('/app/get-client-assign', 'ClientProductController@get_client_assign');
Route::post('/app/store-client-product', 'ClientProductController@create');
Route::post('/app/client-product-dassign', 'ClientProductController@client_product_dassign');

//report
Route::get('/app/product-report/{id}', 'ReportController@product_report');
Route::get('/app/client-report/{id}', 'ReportController@client_report');
Route::get('/app/client-current-product/{id}', 'ReportController@client_current_product');

// Role 
Route::get('/app/get-role', 'RoleController@index');
Route::post('/app/store-role', 'RoleController@create');
Route::post('/app/update-role', 'RoleController@update');
Route::post('/app/delete-role', 'RoleController@destroy');



Route::get('/slug', 'AdminController@index');
Route::any('{slug}', 'AdminController@index')->where('slug', '.*');
