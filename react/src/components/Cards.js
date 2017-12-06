import React from 'react'

const Cards = () => (
  <div className="row">
    <div className="col-lg-12">
        <div className="hpanel">
            <div className="panel-heading hbuilt">                
                This is a basic table design
            </div>
            <div className="panel-body">
                <div className="table-responsive">
                <table cellpadding="1" cellspacing="1" className="table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Phone</th>
                        <th>Street Address</th>
                        <th>City</th>
                        <th>Country</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Abraham</td>
                        <td>076 9477 4896</td>
                        <td>294-318 Duis Ave</td>
                        <td>Vosselaar</td>
                        <td>Belgium</td>
                    </tr>
                    <tr>
                        <td>Phelan</td>
                        <td>0500 034548</td>
                        <td>680-1097 Mi Rd.</td>
                        <td>Lavoir</td>
                        <td>Pakistan</td>
                    </tr>
                    <tr>
                        <td>Raya</td>
                        <td>(01315) 27698</td>
                        <td>Ap #289-8161 In Avenue</td>
                        <td>Santomenna</td>
                        <td>Burkina Faso</td>
                    </tr>
                    <tr>
                        <td>Azalia</td>
                        <td>0500 854198</td>
                        <td>226-4861 Augue. St.</td>
                        <td>Newtown</td>
                        <td>Christmas Island</td>
                    </tr>
                    <tr>
                        <td>Garth</td>
                        <td>(01662) 59083</td>
                        <td>3219 Elit Avenue</td>
                        <td>Ternitz</td>
                        <td>Saint Martin</td>
                    </tr>
                    <tr>
                        <td>Selma</td>
                        <td>0877 118 6905</td>
                        <td>P.O. Box 410, 7331 Nec, St.</td>
                        <td>Glenrothes</td>
                        <td>Korea, North</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            </div>
            <div className="panel-footer">
                Table - 6 rows
            </div>
        </div>
    </div>
</div>
)

export default Cards