@extends('layouts.admin.email')

@section('content')
    <!-- Body start here -->
    <tr>
        <td align="center">
            <table width="600" cellspacing="0" cellpadding="0" border="0" align="center">
                <tbody>
                    <tr>
                        <td style="color: #000000; font-size: 15px; font-family: 'Montserrat', sans-serif; line-height: 20px;" align="center">
                            Hi <strong>{{ $user_name }}</strong> !
                        </td>
                    </tr>
            
                    <tr>
                        <td style="font-size: 25px; line-height: 10px;" height="10">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="color: #000000; font-size: 15px; font-family: 'Montserrat', sans-serif; line-height: 20px;" align="center">
                            Someone recently requested a password change for your Okay Tickets account. If this was you, you can set the new passweord here: 
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 20px; line-height: 10px;" height="10">&nbsp;</td>
                    </tr>
                

                    <tr>
                        <td style="font-size: 20px; line-height: 10px;" height="10">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="color: #ffffff; font-size: 12px; font-family: 'Montserrat', sans-serif; line-height: 25px;" align="center">
                            <!-- ======= section link ======= -->
                            <a href="{{ $url }}" style="text-decoration: none; color: #ffffff; background-color: #881465; padding: 8px 20px;" >RESET PASSWORD</a>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 20px; line-height: 10px;" height="10">&nbsp;</td>
                    </tr>

                    <tr>
                        <td style="font-size: 20px; line-height: 10px;" height="10">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="color: #000000; font-size: 15px; font-family: 'Montserrat', sans-serif; line-height: 20px;" align="center">
                            If you don't want to change your password or didn't requested this, just ignore and delete this message.
                        </td>
                    </tr>
                    <tr>
                        <td style="color: #000000; font-size: 15px; font-family: 'Montserrat', sans-serif; line-height: 20px;" align="center">
                            To keep your account safe, please don't forward this email to anyone.
                        </td>
                    </tr>
                    
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td style="font-size: 80px; line-height: 40px;" height="60">&nbsp;</td>
    </tr>
    <!-- Body end  -->
@endsection

