echo "test"
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_bam_correct_merged/GN1.bam* ./RILs_ALL_bam_correct_merged/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_bam_correct_merged/GN122.bam* ./RILs_ALL_bam_correct_merged/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_bam_correct_merged/GN124.bam* ./RILs_ALL_bam_correct_merged/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_bam_correct_merged/GN182.bam* ./RILs_ALL_bam_correct_merged/

ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/RIL1.bam* ./RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/RIL122.bam* ./RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/RIL124.bam* ./RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/RIL182.bam* ./RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/

cp ../Prepare0_mPing_excision_Identification/input/RILs.ALL_mPing_Ping.gff ./
cp ../Prepare0_mPing_excision_Identification/input/MSU_r7.Pseudo_mPing_Ping_514.gff ./
cp ../Prepare0_mPing_excision_Identification/bin/mPing_Boundary_Coverage.py ./
cp ../Prepare0_mPing_excision_Identification/bin/Ping_number_RILs.High_exicison.py ./
cp ../Prepare0_mPing_calls/RIL272_RelocaTEi.Jinfeng_Lulu.ping_code.table.txt ./
cp ../Prepare0_mPing_excision_Identification/bin/Ping_number_RILs.High_exicison_Ref.py ./
cp ../Prepare0_mPing_excision_Identification/bin/run_mPing_Boundary_Coverage_Ref.sh ./
cp ../Prepare0_mPing_excision_Identification/bin/mPing_Boundary_Coverage_Ref.py ./
cp ../Prepare0_mPing_excision_Identification/input/Parent.Pseudo_mPing_Ping_Pong_57.Ref_Shared.gff ./
cp ../Prepare0_mPing_excision_Identification/input/Parent.ALL.mPing_Ping_Pong.Ref_Shared.gff ./
cp ../Prepare0_mPing_excision_Identification/bin/Sum_excision_distance.py Sum_mPing_excision_Ref.py
cp ../Prepare0_mPing_excision_Identification/input/Parent.ALL.mPing.415.gff ./
cp ../Question4_excision_single_ping_rils/00.Pseudogenome/HEG4.ALL.ping.gff ./
cat Parent.ALL.mPing.415.gff HEG4.ALL.ping.gff > Parent.ALL.mPing_Ping.422.gff

sbatch run_mPing_Boundary_Coverage.sh
python Ping_number_RILs.High_exicison.py --csv output_MSU7_nonreference_514_mPing --ping_code RIL272_RelocaTEi.Jinfeng_Lulu.ping_code.table.txt --output output_MSU7_nonreference_514_mPing_GT_Ping_code

echo "run"
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_bam_correct_merged/*.bam* ./RILs_ALL_bam_correct_merged/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/*.bam* ./RILs_ALL_unmapped_mping_bam_RILs_514_mPing_Ping/
ln -s `pwd`/../Prepare0_mPing_excision_Identification/input/RILs_ALL_unmapped_mping_bam_Ref_57_mPing_Ping_Pong/*.bam* RILs_ALL_unmapped_mping_bam_Ref_57_mPing_Ping_Pong/

#nonreference
sbatch run_mPing_Boundary_Coverage.sh
python Ping_number_RILs.High_exicison.py --csv output_MSU7_nonreference_514_mPing --ping_code RIL272_RelocaTEi.Jinfeng_Lulu.ping_code.table.txt --output output_MSU7_nonreference_514_mPing_GT_Ping_code
cd output_MSU7_nonreference_514_mPing_GT_Ping_code
ln -s Chr3_28019798_28019800.matrix.csv Chr3_28019800_28019802.matrix.csv
ln -s Chr9_10863116_10863118.matrix.csv Chr9_10863118_10863120.matrix.csv
ln -s Chr9_13736139_13736141.matrix.csv Chr9_13736141_13736143.matrix.csv
ln -s Chr9_16690610_16690612.matrix.csv Chr9_16690612_16690614.matrix.csv
python Sum_mPing_excision.py --dir output_MSU7_nonreference_514_mPing_GT_Ping_code --gff Parent.ALL.mPing_Ping.422.gff

#reference
sbatch run_mPing_Boundary_Coverage.sh
python Ping_number_RILs.High_exicison_Ref.py --csv output_MSU7_reference_57_mPing --ping_code RIL272_RelocaTEi.Jinfeng_Lulu.ping_code.table.txt --gff Parent.ALL.mPing_Ping_Pong.Ref_Shared.gff --output output_MSU7_reference_57_mPing_GT_Ping_code
python Sum_mPing_excision_Ref.py --dir output_MSU7_reference_57_mPing_GT_Ping_code --gff Parent.ALL.mPing_Ping_Pong.Ref_Shared.gff
grep "Pong" output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.list > output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.Pong.list
grep "mping" output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.list > output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.mPing.list
grep -v "mping" output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.list | grep -v "Pong" > output_MSU7_reference_57_mPing_GT_Ping_code.mping_excision.Ping.list

#footprint
#old version
awk '$2>=5' ../Prepare0_mPing_excision_footprint/bin/Excision_newpipe_version1.footprint.list.noPing.txt > High_excision_mPing_14_footprint_old_version.list.txt
