function bucharest(city_source)
	distance = {"Arad" 366;
				"Bucharest" 0;
				"Craiova" 160;
				"Dobreta" 242;
				"Eforie" 161;
				"Fagaras" 176;
				"Giurgiu" 77;
				"Hirsova" 151;
				"Iasi" 226;
				"Lugoj" 244;
				"Mehadia" 241;
				"Neamt" 234;
				"Oradea" 380;
				"Pitesti" 100;
				"Rimnicu Vilcea" 193;
				"Sibiu" 253;
				"Timisoara" 329;
				"Urziceni" 80;
				"Vaslui" 199;
				"Zerind" 374 
				};
				 
	node = { "Oradea" "Zerind" 71;
			 "Oradea" "Sibiu" 151;
			 "Zerind" "Arad" 75;
			 "Zerind" "Oradea" 71;
			 "Arad" "Zerind" 75;
			 "Arad" "Sibiu" 140;
			 "Arad" "Timisoara" 118;
			 "Sibiu" "Arad" 140;
			 "Sibiu" "Oradea" 151;
			 "Sibiu" "Fagaras" 99;
			 "Sibiu" "Rimnicu Vilcea" 80;
			 "Timisoara" "Arad" 118;
			 "Timisoara" "Lugoj" 111;
			 "Lugoj" "Timisoara" 111;
			 "Lugoj" "Mehadia" 70;
			 "Mehadia" "Lugoj" 70;
			 "Mehadia" "Dobreta" 75;
			 "Dobreta" "Mehadia" 75;
			 "Dobreta" "Craiova" 120;
			 "Craiova" "Dobreta" 120;
			 "Craiova" "Rimnicu Vilcea" 146;
			 "Craiova" "Pitesti" 138;
			 "Rimnicu Vilcea" "Craiova" 146;
			 "Rimnicu Vilcea" "Sibiu" 80;
			 "Rimnicu Vilcea" "Pitesti" 97;
			 "Pitesti" "Rimnicu Vilcea" 97;
			 "Pitesti" "Craiova" 138;
			 "Pitesti" "Bucharest" 101;
			 "Fagaras" "Sibiu" 99;
			 "Fagaras" "Bucharest" 211;
			 "Giurgiu" "Bucharest" 90;
			 "Neamt" "Iasi" 87;
			 "Iasi" "Neamt" 87;
			 "Iasi" "Vaslui" 92;
			 "Vaslui" "Iasi" 92;
			 "Vaslui" "Urziceni" 142;
			 "Urziceni" "Vaslui" 142;
			 "Urziceni" "Hirsova" 98;
			 "Urziceni" "Bucharest" 85;
			 "Hirsova" "Urziceni" 98;
			 "Hirsova" "Eforie" 86;
			 "Eforie" "Hirsova" 86;
			 };
	   
	#city_source = "Arad";
	city_destiny = "Bucharest";
	city_choice = city_source;

	#matrix city / distance
	#matrix = {1000,3} = {city_name distance_total cost};
	# indicates how many rows are there in the matrix
	row = 0;
	# indicates how many rows are there in the matrix_ignore
	row_ignore = 0;
    # index to access the table/matrix "distance", used in the while statement
	row_dist = 1;
	# Cost used by the city analised, representing the cost to get to this city
	last_cost = 0;

	while row_dist <= 20
		city = distance{row_dist,1};
		if (strcmp(city, city_choice) == 1)
			printf("Distancia em linha reta de %s até %s: %d\n", city, city_destiny, distance{row_dist,2});
			# show neighbors, the possible routes/paths
			# row_node is the index to access the table/matrix "node"
			for row_node=1:42 
				if(strcmp(node{row_node,1},city) == 1)
					#find distance between neighbor and Bucharest
					for row_neighbor=1:20 
						neighbor = distance{row_neighbor,1};
						if (strcmp(neighbor, node{row_node,2}) == 1)
							#save the information about the neighbor in variables
							distanceToBucharest = distance{row_neighbor,2}; 
							city_origin = node{row_node,1}; 
							city_node = node{row_node,2};
							city_distance = node{row_node,3};
							break;
						endif
					endfor
					# calculate cost
					cost = last_cost + city_distance;
					#calculate distante_total
					distance_total = cost + distanceToBucharest;				
					printf("%s ate %s >>\t %d + %d = %d\n", city_origin, city_node, cost, distanceToBucharest, distance_total);  
					# insert data in matrix
					row = row + 1;
					matrix{row,1} = city_node;
					matrix{row,2} = distance_total;
					matrix{row,3} = cost;
					matrix{row,4} = city_origin;
				endif
			endfor
			# add the city recently analised to the matrix_ignore list
			# This is important because the algorithm can't go back to the previous city, which was recently analised
			row_ignore = row_ignore + 1;
			matrix_ignore{row_ignore} = city_choice;
			# we choose an absurd value for the shortest_distance,
			# so the first valid city passes the if statements and gets the city_choice
			shortest_distance = 10000;
			# Check matrix and Select the city with shortest distance_total
			for index=1:row
				# Check if the city is valid, or is in the extreme
				city_valid = 1;
				for index_ignore=1:row_ignore
					if(strcmp(matrix{index,1}, matrix_ignore{index_ignore}) == 1);
						city_valid = 0;
						break;
					endif
				endfor                
				#if city is valid, it can be analised to be the next city_choice
				if(city_valid == 1)
					if(matrix{index,2} < shortest_distance)
						shortest_distance = matrix{index,2};
						# city_choice = city with shortest_distance;
						city_choice = matrix{index,1};
					endif
				endif
			endfor
			printf("Cidade escolhida: %s\n\n", city_choice);
			
			# get last_cost for the next iteraction
			for r=1:row
				if (strcmp(matrix{r,1}, city_choice) == 1)
					if(matrix{r,2} == shortest_distance)
						last_cost = matrix{r,3};
					endif
				endif
			endfor
		endif
		# next iteraction
		if(row_dist < 20)
			row_dist = row_dist + 1;
		#when the next city_choice be "Bucharest", it means that the program has found the shortest way to Bucharest.
		# In other words, end of the A* algorithm, end of the program.
		elseif(strcmp(city_choice,"Bucharest")) 
			row_dist = 69; #out, endprogram
			printf("Solucao otima encontrada!\nFim do programa!\n");
		# restart at the beginning of the table
		else
			row_dist = 1;
		endif
		# printf("i = %d\n", i);
	endwhile
endfunction
