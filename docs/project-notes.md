# Project notes (knowledge base)

The background, findings and open questions gathered while planning the project. Read this together with `CLAUDE.md` before continuing the work.

## Equipment already owned
- **RadioMaster TX16S** (first edition, not MKII)
  - Runs **OpenTX** → upgrade to EdgeTX once the battery is healthy (back up the models first).
  - Internal module is **MULTI 4-in-1**, MPM firmware v1.3.1.36, with no ELRS. One model ("beta") is set to Internal OFF / External **CRSF**, and the JR bay is **empty**, so a CRSF module was probably fitted there before.
  - Battery: RadioMaster 2S Li-ion 7.4 V 5000 mAh, XT30 + balance lead. It measured **5.8 V, then 5.3 V under load (≈2.65 V/cell)**: deep discharge. Recovery plan: ToolkitRC M7, LiIon 2S mode, **0.3 A** until both cells are > 3.3 V, then 1–2 A. Check the per-cell balance first; if one cell is much lower than the other, replace the pack. Don't power the radio until it's charged.
  - The RTC battery is flat too (clock shows 1 Jan), so log timestamps will be wrong.
- **UNI-T UT33D** multimeter.
- **Raspberry Pi** (model to confirm; a Pi 4 is marginal for VIO, a Pi 5 is preferred for M7).

## Purchasing notes
- Buy only from **official brand stores** on AliExpress (T-Motor/LIGPOWER, ToolkitRC, RadioMaster, Holybro).
- **Check the variant before paying.** The headline price is often for the cheapest variant. Make sure of: 4 motors + 4 ESCs; charger **with ADP100**; Pixhawk Model A + PM02 V3 + M10; Ranger in **full JR size** (not Micro/Nano).
- Holybro doesn't list an AliExpress store among its official dealers. **ZDrone** (zdrone.co.il) is Holybro's Israeli dealer, so compare its prices.
- **Avoid "Pixhawk 6C PRO" clone kits** (OLED, I2C board, "PWM module"). That model doesn't exist at Holybro, and its sensors are unknown.
- **Pixhawk 6X** (~₪1,700) is overkill here. It also needs a *digital* power module (PM02D).
- LiPo / Li-ion **batteries rarely ship to Israel**, so buy them locally.
- Holybro was closed 22–26 Oct 2026, so expect delays.

### Links
| Item | Link |
|---|---|
| Pixhawk 6C Mini + PM02 + M10 | https://www.aliexpress.us/item/3256810094050147.html · https://holybro.com/products/pixhawk-6c-mini |
| T-Motor Air Gear 450 II | https://www.aliexpress.com/item/32964124848.html |
| T-Motor Air Gear 450 | https://www.aliexpress.com/item/32455363539.html |
| T1045 II props | https://www.aliexpress.com/i/33015568099.html |
| ToolkitRC M7 + ADP100 | https://www.aliexpress.us/item/3256811816904764.html |
| Carbon tube 16×14 | https://www.aliexpress.com/i/3256805954854384.html |
| XT60 + 14AWG | https://www.aliexpress.com/item/1005006069296787.html |
| BX100 checker | https://www.aliexpress.us/item/3256804426693804.html |
| LiPo bag | https://www.aliexpress.com/i/3256803957775975.html |
| RadioMaster Ranger (JR) | https://www.aliexpress.us/item/3256804856199626.html |
| RadioMaster RP2 | https://www.aliexpress.com/i/3256804533916802.html |
| TX16S spare battery | https://www.aliexpress.com/item/4001019398608.html |

## Regulatory (Israel), to be confirmed with CAAI
- **Theory exam:** self-study is fine. Computerised, ~35 questions, pass mark 70, fee ~₪400–420. Topics: aviation law and regulations, NOTAM, meteorology (METAR/TAF), aerodynamics and systems.
- **Practical test:** the sources conflict.
  - mgur.com: none needed below 4 kg; needed for the 25 kg and 2,000 kg categories (~₪1,760), with registration under an air operator.
  - takefpv.co.il: no practical test for the 25 kg category.
  - preflight.co.il: the practical-test request needs an instructor's annex and the operator's details.
  - → **Call CAAI pilot licensing: 03-9774504.**
- The industry target is the **"external pilot" (VLOS) permit**, as in XTEND's Engineering Pilot posting ("RATA drone pilot certification for open-area operations").
- Schools near Tel Aviv: Drone Options (Rishon LeZion, self-study theory site + 1–3 practical days), Shirgal-Wings (Ramat HaSharon), Preflight.
- An own-built aircraft used for development may need a CAAI **experimental airworthiness certificate**, so ask CAAI or the school.
- **Radio:** 5.8 GHz transmitters are restricted for import and use, and wireless gear may need Ministry of Communications approval. Hence ELRS at 2.4 GHz and no analog FPV video. Check the approved-models list before buying any transmitter.

## Future upgrades / learning path
- **Modern ESCs:** a 4-in-1 with AM32 / BLHeli_32 and bidirectional DShot → RPM-based harmonic notch.
- **DroneCAN GPS** (M10 CAN variant), which builds on CAN experience.
- **GPS-denied navigation (M7):** optical flow + rangefinder (e.g. Matek 3901-L0X) → VIO on the companion (ORB-SLAM3, VINS-Fusion, OpenVINS) → `VISION_POSITION_ESTIMATE`. Map matching against satellite imagery is the hard, commercial-grade step. Evaluate against GPS ground truth with RMSE and drift as % of distance travelled.
- **Video:** first H.264 from the Pi over Wi-Fi (100–300 m, 150–300 ms); later perhaps OpenHD / WFB-ng, kept within the legal TX power.
- **Manual piloting skill:** practise in an FPV simulator (Liftoff, VelociDrone, Uncrashed) with the TX16S as a USB joystick. Industry flight-test roles require proven manual piloting of both quads and fixed-wing aircraft.
- **A second airframe** later: a 7" tactical-style quad on ArduPilot. Most of the knowledge carries over.

## Open items
- [ ] Revive the TX16S battery; upgrade to EdgeTX
- [ ] Confirm the licence requirements with CAAI
- [ ] Confirm the Raspberry Pi model
- [ ] Run `tools/setup-github.ps1`
