import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem()
        ],
        
      ),
    );
  }
}


class ProductListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
        height: 150,
        color: Colors.white70,
        child: Row(

          children: [
            GestureDetector(
              onTap: (){
                 Navigator.of(context).pushNamed("/pdetails");
              },
              child: Hero(
                tag:"fert",
                child: Image.network(
                  "https://images.orgill.com/large/7615198.JPG",
                  width: 150,
                // color: Colors.pink,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:100),
              // color: Colors.yellow,
              child: Column(
                
          
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ksh.4,000",style: TextStyle(
                    fontSize: 30
                  ),),
                  Text("Mbogwa Frydfgkjgkjfgkfjg",style: TextStyle(
                    fontSize: 20
                  ),),
                  Text("Stock :9000Kg",style: TextStyle(
                    fontSize: 20
                  ),),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 70,),
                      MaterialButton(color:Colors.green,onPressed: () {  
                        Navigator.of(context).pushNamed("/pdetails");
                      },
                      child: Text("Buy"),),
                   
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    )
      
    ;
  }
}