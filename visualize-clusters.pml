


bg_color white 
show_as cartoon





python 
###############################################

print sys.argv
for i, arg in enumerate (sys.argv[1:]): print i, arg




cluster_filename = sys.argv[1]
img_path = sys.argv[2]
img_filename = img_path+'/'+sys.argv[1]+'.png'


clusters_definition = []


with open(cluster_filename, 'r') as cluster_file:        
        
        clusters_definitions = False
        # False while 'begin' tag is not reached
        # then True during cluster definition 
        # then False after cluster definition (when tag ')' is not reached ) 
        
        for line in cluster_file:
            if line == "begin\n": 
                clusters_definitions = True
            elif line == ")\n": 
                clusters_definitions = False
            elif clusters_definitions:  # now we are in clusters definition : 
                
                    if line[0].isdigit() : # begin of a cluster definition 
                        #rm the cluster id from the line so it won't be assign as cluster members
                        cluster_id, line = line.split(' ', 1)
                        cluster_members = []                        
                    
                    #line contains only members (cluster id was previously removed)
                    cluster_members.extend (line.split()) 
                    
                    if cluster_members[-1] == "$":  #end of cluster definition 
                        cluster_members = cluster_members[:-1]  #-1 : '$' tag
                        clusters_definition.append(cluster_members)
                        

for cluster_idx, members in enumerate (clusters_definition) : 
    print cluster_idx
    sel_name = 'cluster{0}'.format(cluster_idx)
    sel_expression = "resi "+'+'.join(members)
    cmd.select(sel_name, sel_expression)
    cmd.color( cmd.get_color_indices()[cluster_idx + 1][0] , sel_name)



cmd.png(img_filename)
###########################################################
python end




print 'clusters displayed'
quit


